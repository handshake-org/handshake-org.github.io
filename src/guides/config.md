# HSD Configuration

By default, the mainnet hsd config files will reside in `~/.hsd/hsd.conf` (node) and
`~/.hsd/hsw.conf` (wallet). Any parameter passed to hsd at startup will have precedence
over the config file. Even if you are just running `hs-client` without hsd
installed (to access a remote server, for example) the configuration files
would still reside in `~/.hsd/`

For example:

``` bash
hsd --network=regtest --api-key=menace
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
wiil create a datadir of `~/.hsd_test`, containing a chain database, wallet
database and log file.

``` bash
$ hsd --prefix ~/.hsd_test
```

## Preprocessor Options

The following configuration settings are only available for the command line when
hsd is launched. They WILL NOT be read from a `hsd.conf` file or pulled from the
shell environment. This is because they are processed directly by the `$PATH` command
which executes scripts in the repository at `bin/hsd` and `bin/node`.

- `--no-wallet`: Launches hsd without a wallet plugin, allowing `hs-wallet` to be run in a separate process.
- `--spv`: Launches hsd in SPV (Simplified Payment Verification) mode, aka [BIP37](https://github.com/bitcoin/bips/blob/master/bip-0037.mediawiki).
- `--daemon`: Launches hsd in the background (a detached child process of the command script).
- `--help`: Displays help information about hsd and quits.
- `--version`: Displays the version of hsd set in its package.json and quits.

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

### Logger Options

- `log-level`: `error`, `warning`, `info`, `debug`, or `spam` (default: debug).
- `log-console`: `true` or `false` - whether to actually write to stdout/stderr if foregrounded (default: true).
- `log-file`: Whether to use a log file (default: true).

### Chain Options

Note that certain chain options affect the format and indexing of the chain database and must be passed in consistently each time.

- `prune`: Prune from the last 288 blocks (default: false).
- `checkpoints`: Use checkpoints and getheaders for the initial sync (default: true).
- `coin-cache`: The size (in MB) of the in-memory UTXO cache. By default, there is no UTXO cache enabled. To get a good number of cache hits per block, the coin cache has to be fairly large (60-100mb recommended at least).
- `index-tx`: Index transactions (enables transaction endpoints in REST api) (default: false).
- `index-address`: Index transactions and utxos by address (default: false).

### Mempool Options

- `mempool-size`: Max mempool size in MB (default: 100).
- `persistent-mempool`: Save mempool to disk and read into memory on boot (default: false).

### Pool Options

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

### Miner Options

- `coinbase-flags`: Coinbase flags (default: mined by hsd).
- `coinbase-address`: List of payout addresses, randomly selected during block creation (comma-separated).
- `max-weight`: Max block weight to mine (default: 4000000).
- `reserved-weight`: Amount of space reserved for coinbase (default: 4000).
- `reserved-sigops`: Amount of sigops reserved for coinbase (default: 400).

### HTTP

- `http-host`: HTTP host to listen on (default: 127.0.0.1).
- `http-port`: HTTP port to listen on (default: 12037 for mainnet).
- `ssl`: Whether to use SSL (default: false)
- `ssl-cert`: Path to SSL cert.
- `ssl-key`: Path to SSL key.
- `api-key`: API key (used for accessing all node APIs, may be different than API key for wallet server).
- `cors`: Enable "Cross-Origin Resource Sharing" HTTP headers (default: false).

Note: For security `cors` should not be used with `no-auth`.\
If enabled you should also enable `wallet-auth` and set `api-key`.

### DNS Resolver options

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
- `wallet-auth`: Enable token auth for wallets (default: false).
- `admin-token`: Token required if `wallet-auth` is enabled: restricts access to [all wallet admin routes.](https://handshake-org.github.io/api-docs/#wallet-admin-commands)

## Example Configurations

_NOTE: unless otherwise specified in [Preprocessor Options](#preprocessor-options), only one set of options is needed to run with the example configuration.
For example if you choose to use a `hsd.conf` file, you will not need to use the command line options._

### Full Node with wallet

This may require up to 200 MB of disk space per day. It is the most private and
secure way to use Handshake for transactions and auctions.

| Command | `~/.hsd/hsd.conf` |
|-|-|
| `hsd` | (none, default parameters are OK) |

### SPV Node with wallet

This may require up to 60 kB of disk space per day. SPV leaks some privacy
and relies on being connecting to at least one "honest" full node, which may
weaken overall security assumptions.

| Command | `~/.hsd/hsd.conf` |
|-|-|
| `hsd --spv` | (none, must use command line argument) |

### Pruned full node with wallet

This will never require more than 400 MB total. Only the last 288 blocks are saved
to disk. Wallet rescans are impossible in this mode. This node will not relay
historical blocks to new bootstrapping nodes but otherwise is fully validating and
just as private and secure as any full node.

| Command | `~/.hsd/hsd.conf` |
|-|-|
| `hsd --prune` | `prune: true` |

### Full Node with wallet as separate process on same machine

Both of these commands must be executed to run full node and wallet separately.

| Command | `~/.hsd/hsd.conf` |
|-|-|
| `hsd --no-wallet` | (none, must use command line argument) |

| Command | `~/.hsd/hsw.conf` |
|-|-|
| `hs-wallet` | (none, default parameters are OK) |

### Full Node with wallet as separate process on DIFFERENT machine

Both of these commands must be executed to run full node and wallet separately.
To run wallet and node remotely, you MUST use a strong `<API key>` and enforce SSL
on the full node. `<https://URL>` MUST be a resolvable domain name secured by legacy certificate authority SSL.

| Command | `~/.hsd/hsd.conf` |
|-|-|
| `hsd --no-wallet \`<br> `--api-key=<API KEY> \`<br>`--http-host=<https://URL> \`<br>`--ssl=true \`<br>`--ssl-cert=<path> \`<br>`--ssl-key=<path>` | <br>`api-key:<API key>`<br>`http-host: <https://URL>`<br>`ssl: true`<br>`ssl-cert: <path>`<br>`ssl-key: <path>` |

| Command | `~/.hsd/hsw.conf` |
|-|-|
| `hs-wallet \`<br>`--node-host=<https://URL> \`<br>`--node-ssl: true \`<br>`--node-api-key: <API key>` | <br>`node-host: <https://URL>`<br>`node-ssl: true`<br>`node-api-key: <API key>` |

### Full Node that allows inbound connections from other full and light clients like `hnsd`

`<IP address>` MUST be your external IP address, publicly accessible by the internet.

| Command | `~/.hsd/hsd.conf` |
|-|-|
| `hsd \` <br> `--bip37=true \` <br> `--listen=true \` <br> `--public-host=<IP address> \`<br>`--max-inbound=100` | <br>`bip37:true`<br>`listen:true`<br>`public-host: <IP address>`<br>`max-inbound: 100` |

### Full Node with public HNS recursive resolver

Note: if you configure this way it is strongly recommended to enable a firewall on your system to mitigate
[amplification attacks](https://www.cloudflare.com/learning/ddos/dns-amplification-ddos-attack/).
This is not a recommended configuration for a fully public server.
If your hsd node is running locally (on your home network or LAN) that should be OK.
`<IP address>` MUST be publicly accessible by the internet
(or just your local network if applicable). You could use `0.0.0.0` for this but that
may disrupt other DNS services using port 53 on the same machine.


| Command | `~/.hsd/hsd.conf` |
|-|-|
| `hsd \`<br>`--rs-host=<IP address> \` <br> `--rs-port=53` |<br>`rs-host: <IP address>`<br>`rs-port: 53` |

### Full Node in "nerd mode"

Useful if you are running a block explorer service or otherwise need access to all
the data hsd could possibly provide.

| Command | `~/.hsd/hsd.conf` |
|-|-|
| `hsd \`<br>`--index-tx=true \`<br>`--index-address=true \`<br>`--log-level=spam` | <br>`index-tx: true`<br>`index-address: true`<br>`log-level: spam` |
