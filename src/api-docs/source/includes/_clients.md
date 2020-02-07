# Configuring Clients

## Default Listeners
```shell--visible
# With curl you just send HTTP Requests based on further docs
curl http://127.0.0.1:14037/ # will get info from regtest
```

By default the API server listens on these `localhost` ports:

Network   | API Port
--------- | -----------
main      | 12037
testnet   | 13037
regtest   | 14037
simnet    | 15037

You can interact with hsd with its REST API as well as with RPC.
There are couple of ways you can use the API:

- `hsd-cli` - methods built specifically into hsd by its developers
- `hsd-cli rpc` - adds functionality that mimics Bitcoin Core RPC
- `javascript` - methods used by `hsd-cli` can be accessed directly from javascript
- `curl` - you can use direct HTTP calls for invoking both REST and RPC API calls

Only thing to keep in mind is authentication, which is described in the ["Authentication"](#authentication) section.


## Configuring hsd-cli

```shell--visible
# You can configure it by passing arguments:
hsd-cli --network=regtest info
hsd-cli info --network=regtest

# Or use environment variables (Starting with HSD_)
export HSD_NETWORK=regtest
export HSD_API_KEY=$YOUR-API-KEY
hsd-cli info
```

Install `hsd-cli` and `hsw-cli` command line tools with the `hs-client` package.
Included with `hsd` by default, but can be installed separately:
`npm install -g hs-client`

`hsd-cli` params:

### General configuration:

Config    | Options                      | Description
--------- | -----------                  | -----------
network   | `main`, `testnet`, `regtest` | This will configure which network to load, also where to look for `hsd.conf` file
uri, url  | Base HTTP URI                | This can be used for custom port
api-key   | _string_                     | Secret used by RPC for authorization

### Wallet specific configuration:

Config    | Options         | Description
--------- | -----------     | -----------
id        | _string_        | Specify which account to use by default
token     | _string_        | Token specific wallet


```shell--visible
# Example hsd.conf syntax:
network: main
prefix: ~/.hsd
api-key: <api-key>
```

### hsd.conf and hsw.conf files

These files may contain any of the configuration parameters, and will be interpreted by hs-client at startup. The node and wallet clients look for their own respective conf files.

[A sample hsd.conf file is included in the code repository](https://github.com/handshake-org/hsd/blob/master/etc/sample.conf)




<aside class="notice">
Some commands might accept additional parameters.
</aside>

## Using Javascript Clients

```javascript--visible
const {NodeClient, WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const walletOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);
const wallet = new WalletClient(walletOptions);
```

You can also use the API with a Javascript library (used by `hsd-cli`).
There are two objects: `NodeClient` for general API and `WalletClient` for wallet API.
`hsd` also provides an object `Network` and its method `get` which will return the default configuration paramaters for a specified network.
Custom port numbers are also configurable by the user.

`NodeClient` and `WalletClient` options:

Config    | Type                         | Description
--------- | -----------                  | -----------
network   | _string_ | Network to use: `main`, `testnet`, `regtest`
port      | _int_                          | hsd socket port (defaults specific for each network)
host      | _string_ | hsd API host URI (defaults to 127.0.0.1)
apiKey    | _string_                       | API secret

