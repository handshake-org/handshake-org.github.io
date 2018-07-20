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

You can interact with hskd with its REST API as well as with RPC.
There are couple of ways you can use the API:

- `hsk-cli` - methods built specifically into hskd by its developers
- `hsk-cli rpc` - adds functionality that mimics Bitcoin Core RPC
- `javascript` - methods used by `hsk-cli` can be accessed directly from javascript
- `curl` - you can use direct HTTP calls for invoking both REST and RPC API calls

Only thing to keep in mind is authentication, which is described in the ["Authentication"](#authentication) section.


## Configuring hsk-cli

```shell--visible
# You can configure it by passing arguments:
hsk-cli --network=regtest info
hsk-cli info --network=regtest

# Or use environment variables (Starting with HSK_)
export HSK_NETWORK=regtest
export HSK_API_KEY=$YOUR-API-KEY
hsk-cli info
```

Install `hsk-cli` and `hwallet-cli` command line tools with the `hsk-client` package.
Included with `hskd` by default, but can be installed separately:
`npm install -g hsk-client`

`hsk-cli` params:

### General configuration:

Config    | Options                      | Description
--------- | -----------                  | -----------
network   | `main`, `testnet`, `regtest` | This will configure which network to load, also where to look for `hsk.conf` file
uri, url  | Base HTTP URI                | This can be used for custom port
api-key   | _string_                     | Secret used by RPC for authorization

### Wallet specific configuration:

Config    | Options         | Description
--------- | -----------     | -----------
id        | _string_        | Specify which account to use by default
token     | _string_        | Token specific wallet


```shell--visible
# Example hsk.conf syntax:
network: main
prefix: ~/.hsk
api-key: <api-key>
```

### hsk.conf and wallet.conf files

These files may contain any of the configuration parameters, and will be interpreted by hsk-client at startup. The node and wallet clients look for their own respective conf files.

[A sample hsk.conf file is included in the code repository](https://github.com/handshake-org/hskd/blob/master/etc/sample.conf)




<aside class="notice">
Some commands might accept additional parameters.
</aside>

## Using Javascript Clients

```javascript--visible
const {NodeClient, WalletClient} = require('hsk-client');
const {Network} = require('hskd');
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

You can also use the API with a Javascript library (used by `hsk-cli`).
There are two objects: `NodeClient` for general API and `WalletClient` for wallet API.
`hskd` also provides an object `Network` and its method `get` which will return the default configuration paramaters for a specified network.
Custom port numbers are also configurable by the user.

`NodeClient` and `WalletClient` options:

Config    | Type                         | Description
--------- | -----------                  | -----------
network   | _string_ | Network to use: `main`, `testnet`, `regtest`
port      | _int_                          | hskd socket port (specific for each network)
apiKey    | _string_                       | API secret

