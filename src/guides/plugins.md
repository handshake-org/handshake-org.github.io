# Developing and using plugins for `hsd`

`hsd` has a plugin interface that allows developers to expand or modify any
property of any module within the system, and listen for any internal events.
The default wallet used by `hsd` is in fact a
[plugin](https://github.com/handshake-org/hsd/blob/a94ce87a886e943a68d4a3e67068f6e473c21156/lib/wallet/plugin.js)
that is integrated by
default when hsd is launched from the executable
[`bin/node`](https://github.com/handshake-org/hsd/blob/a94ce87a886e943a68d4a3e67068f6e473c21156/bin/node#L39-L43).

Because a plugin could easily modify consensus code, EXTREME CAUTION must be
taken by users when running `hsd` with a plugin, or when developing one themselves.

Plugins are ingested by `hsd` at launch by passing a path to a plugin file or directory
that contains a `package.json` file with a `"main": "<relative/path/to/file>"`
property. Plugin files can be identified on the command line, in `hsd.conf`
files or specified by the environment.

## Example plugin installation and integration:

Command line:

(Plugins can be installed from npm directly into `hsd/node_modules`)

```
$ cd hsd
$ npm install hstratum
$ hsd --plugins hstratum
```

Shell environment:

```
$ export HSD_PLUGINS=/Users/hsd-developer/work/holdmyhand
$ hsd
```

Conf file:

(`~/.hsd/hsd.conf`)

```
plugins: /Users/hsd-developer/work/holdmyhand
```

## Plugin development

`FullNode`, `SPVNode` and `WalletNode` modules (which all extend `lib/node/node.js`)
can load plugins. A plugin file MUST have at least the following architecture:

```js
class Plugin {
  constructor(node) {}

  async open() {}
  async close() {}
}

const plugin = exports;
plugin.id = 'plugin_name';
plugin.init = (node) => {
  return new Plugin(node);
};

```

- A plugin is a class
- Plugins must have a static function `init(node)` which takes a `node` parameter (`FullNode`, `SPVNode`, or `WalletNode`)
- Plugins must have `async` internal methods `open()` and `close()`
- Plugins should have an `id` to name the plugin, names of existing internal modules are reserved

The plugin lifecycle relative to `hsd` launch is as follows:

1. `FullNode` is instantiated and populated with default modules (`chain`, `pool`, etc)
2. Event listeners are set for these internal modules
3. Plugins are loaded from the `config` module in order they are passed in
4. `FullNode` is opened:
    - `logger`, `workers`, `chain`, `mempool`, `miner` and `pool` are opened by calling `open()` on each object
    - plugins are opened by calling `open()` on each plugin
    - `http`, `ns`, and `rs` are opened by calling `open()` on each object
5. The process is reversed when the node is closed, calling `close()` on each object

Note that this means that some modules are already opened before plugins, and so some
properties may not be malleable by a plugin.

## Development tips

#### Plugins can share a logger with the host, and identify their own context:

```js
this.logger = node.logger.context('holdmyhand');
this.logger.info('Root nameserver filtering is active.');
```

Log output:

```
[info] (holdmyhand) Root nameserver filtering is active.
```

#### Plugins can listen for events and even stub class methods.
This is an example snippet of a plugin that logs all incoming and outgoing p2p packets:

```js
class Plugin {
  constructor(node) {
    this.pool = node.pool;
    this.init();
  }

  init() {
    // Listen for incoming packet events
    this.pool.on('packet', (packet) => {
      console.log('Incoming packet: ', packet);
    });

    // Wait for pool to be opened
    this.pool.on('peer open', (peer) => {

      // Steal the existing method
      peer.SEND = peer.send;

      // Replace the method with a wrapper listening for outgoing packets
      peer.send = (packet) => {

        // Do something...
        console.log('Outgoing packet: ', packet);

        // ...then return the original method
        peer.SEND(packet);
      };
    });
  }
}
```

## DNS resolver plugins

The HNS root authoritative name server has extra properties that give plugins
more flexibilty inside the module. Users may have specific preferences for how
`hsd` resolves names from the HNS root zone. Some possible modifications are:

- Redirect specific TLD queries to the local ICANN root resolver instead of HNS
- Resolve blocklisted names like `.eth` or `.bit` on external systems like Ethereum or Namecoin
- Detect and block homograph attacks

The `hsd` root server module is in the repository in
[`lib/dns/server.js`](https://github.com/handshake-org/hsd/blob/a94ce87a886e943a68d4a3e67068f6e473c21156/lib/dns/server.js#L109).
A plugin can access the server from an `hsd` `FullNode` or `SPVNode` from its constructor:

```js
constructor(node) {
  this.ns = node.ns;
}
```

Once the server is instantiated the plugin can access certain properties:

### `blacklist`

A `Set` of strings that will not be looked up (a `NXDOMAIN` is returned):

```js
this.ns.blacklist.add('localhost');
```

### `getReserved(tld)`

A `function` that is called with a top-level domain name `String`.
Returns a reserved name `Object` or `null`.

```js
this.ns.getReserved('com');
```

### `signRRSet(Array[wire.Record], Int)`

A `function` that is called with an RR set (`Array[wire.Record]`) and type (`wire.types`)
that signs the set with the HNS root ZSK and pushes the RRSIG back onto the answer
(there is no return value).

```js
this.ns.signRRSet(res.answer, type);
```

### `middle(String, wire.Message)`

An optional `function`, settable by a plugin, that is called with the TLD and the
full request _before_ checking the cache, the blacklist, the HNS root zone, or the
ICANN reserved TLD list. If there is no function provided or if the provided function
returns `null`, the root resolver lookup proceeds as by default. The function may
also return a
[`Message`](https://github.com/chjj/bns/blob/25a2330322b740fa96ed67e5c0d8f0a1de89da55/lib/wire.js#L165)
which is then returned directly to the resolver that made the query. Records in
these responses will appear to come directly from the HNS root zone, so they should
be flagged as authoritative where applicable and signed by the HNS root zone-signing
key where applicable.

```js
this.ns.middle = (tld, req) => {
  const [qs] = req.question;
  const name = qs.name.toLowerCase();
  const type = qs.type;
  const wire = this.ns.wire;

  if (tld === 'bit') {
    const res = new wire.Message();

    // Lookup the full name from the request using a Namecoin full node
    res.answer = this.namecoinClient.lookup(name);

    // Sign the answer with the HNS root ZSK
    this.ns.signRRSet(res.answer, type);

    return res;
  }

  // Bypass if the plugin doesn't care about the name
  return null;
}
```
