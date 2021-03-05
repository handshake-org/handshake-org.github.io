## HSD Configuration

By default, the mainnet hsd config files will reside in `~/.hsd/hsd.conf` and
`~/.hsd/hsw.conf`. Any parameter passed to hsd at startup will have precedence
over the config file. Even if you are just running `hs-client` without hsd
installed (to access a remote server, for example) the configuration files
would still reside in `~/.hsd/`

For example:

``` bash
hsd --network=regtest --api-key=menace --daemon
```

will read the config file at `~/.hsd/regtest/hsd.conf` and ignore any
`network` or `api-key` parameters listed in that file.

All hsd configuration options work in the config file, CLI arguments, process
environment, and in the constructor parameters when instantiating new `node`
objects in JavaScript. Each method has slightly different formatting. Note
specifically the usage of hyphens and capital letters. See the examples below:

| config file | CLI parameter | environment variable | JS object constructor |
|---|---|---|---|
| `network: testnet` | `--network=testnet` | `export HSD_NETWORK=testnet` | `{network: 'testnet'}` |
| `log-level: debug` | `--log-level=debug` | `export HSD_LOG_LEVEL=debug` | `{logLevel: 'debug'}` |
| `max-outbound: 8`  | `--max-outbound=8`  | `export HSD_MAX_OUTBOUND=8`  | `{maxOutbound: 8}`|
| `cors: true`  | `--cors`  | `export HSD_CORS=true`  | `{cors: true}`|

Keep in mind, that setting bash environment variable which will be passed to the `hsd` or `hs-client` subprocesses requires `export` command:
`export HSD_NETWORK=testnet`. 


## Datadir/Prefix

The hsd datadir is determined by the `prefix` option. The following example
wiil create a datadir of `~/.hsd_spv`, containing a chain database, wallet
database and log file.

``` bash
$ hsd --prefix ~/.hsd_spv --spv
```


## Common Options

- `config`: Points to a custom config file, not in the prefix directory.
- `network`: Which network's chainparams to use for the node (main, testnet, regtest, or simnet) (default: main).
- `workers`: Whether to use a worker process pool for transaction verification (default: true).
- `workers-size`: Number of worker processes to spawn for transaction verification. By default, the worker pool will be sized based on the number of CPUs/cores in the machine.
- `workers-timeout`: Worker process execution timeout in milliseconds (default: 120000).

## Node Options

- `prefix`: The data directory (stores databases, logs, and configs) (default=~/.hsd).
- `max-files`: Max open files for leveldb. Higher generally means more disk page cache benefits, but also more memory usage (default: 64).
- `cache-size`: Size (in MB) of leveldb cache and write buffer (default: 32mb).
- `spv`: Enable Simplified Payments Verification (SPV) mode

## Logger Options

- `log-level`: `error`, `warning`, `info`, `debug`, or `spam` (default: debug).
- `log-console`: `true` or `false` - whether to actually write to stdout/stderr if foregrounded (default: true).
- `log-file`: Whether to use a log file (default: true).

## Chain Options

Note that certain chain options affect the format and indexing of the chain database and must be passed in consistently each time.

- `prune`: Prune from the last 288 blocks (default: false).
- `checkpoints`: Use checkpoints and getheaders for the initial sync (default: true).
- `coin-cache`: The size (in MB) of the in-memory UTXO cache. By default, there is no UTXO cache enabled. To get a good number of cache hits per block, the coin cache has to be fairly large (60-100mb recommended at least).
- `index-tx`: Index transactions (enables transaction endpoints in REST api) (default: false).
- `index-address`: Index transactions and utxos by address (default: false).

## Mempool Options

- `mempool-size`: Max mempool size in MB (default: 100).
- `persistent-mempool`: Save mempool to disk and read into memory on boot (default: false).

## Pool Options

- `selfish`: Enable "selfish" mode (no relaying of txes or blocks) (default: false).
- `compact`: Enable compact block relay (default: true).
- `bip37`: Enable serving of bip37 merkleblocks (default: false).
- `listen`: Accept incoming connections (default: false).
- `max-outbound`: Max number of outbound connections (default: 8).
- `max-inbound`: Max number of inbound connections (default: 30).
- `max-proof-rps`: Max `getproof` DNS requests per second (default: 100).
- `seeds`: Custom list of DNS seeds (comma-separated).
- `host`: Host to listen on (default: 0.0.0.0).
- `port`: Port to listen on (default: 12038 for mainnet).
- `brontide-port`: Port for encrypted p2p server to listen on (default: 44806 for mainnet).
- `public-host`: Public host to advertise on network.
- `public-port`: Public port to advertise on network.
- `nodes`: List of target nodes to connect to (comma-separated).

## Miner Options

- `coinbase-flags`: Coinbase flags (default: mined by hsd).
- `coinbase-address`: List of payout addresses, randomly selected during block creation (comma-separated).
- `max-weight`: Max block weight to mine (default: 4000000).
- `reserved-weight`: Amount of space reserved for coinbase (default: 4000).
- `reserved-sigops`: Amount of sigops reserved for coinbase (default: 400).

## HTTP

- `http-host`: HTTP host to listen on (default: 127.0.0.1).
- `http-port`: HTTP port to listen on (default: 12037 for mainnet).
- `ssl`: Whether to use SSL (default: false)
- `ssl-cert`: Path to SSL cert.
- `ssl-key`: Path to SSL key.
- `api-key`: API key (used for accessing all node APIs, may be different than API key for wallet server).
- `cors`: Enable "Cross-Origin Resource Sharing" HTTP headers (default: false).

Note: For security `cors` should not be used with `no-auth`.\
If enabled you should also enable `wallet-auth` and set `api-key`.

## DNS Resolver options

- `ns-host`: Host for authoritative nameserver to listen on (default: 127.0.0.1)
- `ns-port`: Port for authoritative nameserver to listen on (default: 5349 for mainnet)
- `public-host`: (Same as pool option) applies to authoritative nameserver
- `rs-host`: Host for recursive nameserver to listen on (default: 127.0.0.1)
- `rs-port`: Port for recursive nameserver to listen on (default: 5350 for mainnet)
- `rs-no-unbound`: Whether to use the hsd JavaScript resolver as the recursive resolver (default: false)


## Wallet options

These options must be saved in `hsw.conf`. They can also be passed as
environment variables or command-line variables if they are preceded with a
`wallet-` prefix (`WALLET_` for env vars).

For example, to run a hsd and wallet node on a remote server that you can access
from a local machine, you would could use the following examples:

Example using hsw.conf:
```
network: testnet
wallet-auth: true
api-key: hunter2
http-host: 0.0.0.0
```

Example using CLI options:
```bash
$ ./bin/hsd --network=testnet --http-host=0.0.0.0 --wallet-http-host=0.0.0.0 --wallet-api-key=hunter2 --wallet-wallet-auth=true
```

Example using ENV:
```bash
$ HSD_NETWORK=testnet HSD_HTTP_HOST=0.0.0.0 HSD_WALLET_HTTP_HOST=0.0.0.0 HSD_WALLET_API_KEY=hunter2 HSD_WALLET_WALLET_AUTH=true ./bin/hsd
```

### hsd client:

- `node-host`: Location of hsd node HTTP server (default: localhost).
- `node-port`: Port of hsd node HTTP server (defaults to RPC port of network).
- `node-ssl`: Whether to use SSL (default: false).
- `node-api-key`: API-key for hsd HTTP server.

### Wallet database:

- `max-files`: Max open files for leveldb.
- `cache-size`: Size (in MB) of leveldb cache and write buffer.

### Wallet http server:

- `ssl`: Whether to use SSL (default: false).
- `ssl-key`: Path to SSL key.
- `ssl-cert`: Path to SSL cert.
- `http-host`: HTTP host to listen on (default: 127.0.0.1).
- `http-port`: HTTP port to listen on (default: 12039 for mainnet).
- `api-key`: API key (used for accessing all wallet APIs, may be different than API key for node server).
- `cors`: Enable "Cross-Origin Resource Sharing" HTTP headers (default: false).
- `no-auth`: Disable auth for API server and wallets (default: false).
- `wallet-wallet-auth`: Enable token auth for wallets (default: false).
- `wallet-api-key`: Set the token for the wallet authorization.
- `admin-token`: Token required if `wallet-auth` is enabled: restricts access to [all wallet admin routes.](https://handshake-org.github.io/api-docs/#wallet-admin-commands)

### Example configuration file

The following file could be placed at `~/.hsd/hsd.conf` for use with a mainnet hsd node.
It could (for example) be placed at `~/.hsd/testnet/hsd.conf` if the node is started with `hsd --network=testnet`.
All the settings in the example below are defaults, meaning you do NOT need to use
this `hsd.conf` if you do not need to change any of the values. It is
provided only as an example of the configuration file syntax:

- Configuration options are newline delimited.
- The key/value pairs are delimited by a colon.
- All options can be set via command line, environment variable or the config file.
(See top of page)

```
max-inbound: 8
max-outbound: 8
log-level: debug
prune: false
checkpoints: true
rs-port: 5350
```


