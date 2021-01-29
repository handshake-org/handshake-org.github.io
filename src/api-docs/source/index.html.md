---
title: Handshake API Reference

home_link: /

language_tabs: # must be one of https://git.io/vQNgJ
  - shell--curl: cURL
  - shell--cli: CLI
  - javascript

toc_footers:
  - <a href='https://github.com/handshake-org/hsd'>See the code on GitHub</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - clients
  - node
  - coin
  - transaction
  - node_rpc
  - node_rpc_general
  - node_rpc_chain
  - node_rpc_block
  - node_rpc_mempool
  - node_rpc_tx
  - node_rpc_mining
  - node_rpc_network
  - node_rpc_names
  - wallet
  - wallet_admin
  - wallet_accounts
  - wallet_tx
  - wallet_auctions
  - wallet_rpc_auctions
  - wallet_rpc
  - sockets
  - node_sockets
  - wallet_sockets
  - errors

search: true
---

# Introduction

Welcome to the hsd API!

hsd is a fork of [bcoin](https://github.com/bcoin-org/bcoin) and so if you are familiar with it,
you'll find that the API is very similar to the [bcoin API](http://bcoin.io/api-docs/).
bcoin was released with a JSON-RPC API that was based on the Bitcoin Core RPC interface.
The actual Bitcoin Core RPC API has changed a lot since then, but if you are familiar with
using bitcoind, you'll find a lot of the same RPC calls available in hsd.

```
# Examples:

# Get a transaction by hash from the full node HTTP API:


curl http://x:api-key@127.0.0.1:14037/tx/\
  4674eb87021d9e07ff68cfaaaddfb010d799246b8f89941c58b8673386ce294f


# Get a raw transaction by hash from the full node RPC API:


curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{ \
    "method": "getrawtransaction", \
    "params": [ "4674eb87021d9e07ff68cfaaaddfb010d799246b8f89941c58b8673386ce294f"] \
  }'


# Get a transaction by hash from the "primary" wallet HTTP API:


curl http://x:api-key@127.0.0.1:14039/wallet/primary/tx/\
  4674eb87021d9e07ff68cfaaaddfb010d799246b8f89941c58b8673386ce294f


# Get a transaction by hash from the wallet RPC API:


curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ \
    "method": "gettransaction", \
    "params": [ "4674eb87021d9e07ff68cfaaaddfb010d799246b8f89941c58b8673386ce294f" ] \
  }'
```

**There are four API servers in hsd**

The full node and the wallet are separate modules in hsd, and their API servers run on separate ports.
The wallet is configured as a plug-in by default but can actually be run as a separate process
(even on a remote server) using websockets and HTTP requests to sync with the full node.

Network   | Wallet API Port | Node API Port
--------- | --------------- | -------------
main      | 12039           | 12037
testnet   | 13039           | 13037
regtest   | 14039           | 14037
simnet    | 15039           | 15037

In addition, each server has two API formats: JSON-RPC and a RESTful HTTP API.
Much of the functionality is duplicated between the HTTP API and RPC API.
Note that if multiple user-agents are using the wallet at the same time,
the wallet RPC API is not safe as it maintains global state (more on this below)
It is recommended to use the wallet HTTP API in multiprocess/multithreaded environments.

**Indexing**

hsd has two indexer modules that are inactive by default. When turned on, the indexers
enable additional API calls.

Transaction indexer: enabled by `--index-tx=true`. Allows lookup of arbitrary transactions
by their hash (txid). When disabled, the wallet still tracks all of its own transactions
by hash and the full node can still be used to look up UTXO (unspent transaction outputs).
The UTXOs are indexed by outpoint, which is the transaction ID that created the UTXO
along with its index in that transaction.

Address indexer: enabled by `--index-address=true`. Allows lookup of all transactions
involving a certain address.


**Wallet: BIP44**

The hsd wallet follows a [BIP44](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)
structure with cointype `5353` for mainnet. A single hsd instance can have multiple BIP44
wallets in its database.

The hierarchy looks like this:

`WalletDB`: A levelDB database stored in a `wallet` directory, accessed by the wallet module
plugged-in by default to the full node. Can process transactions for multiple wallets.

`Wallet`: A BIP44 wallet based on 128 or 256 bits of entropy and backed up by a 12- or 24-
word phrase. Multiple accounts can be derived from a single wallet.

`Account`: A branch of a BIP44 wallet. Multiple addresses can be derived from a single
account, and the wallet can be configured to spend coins from a single specified account.

`Address`: A hash of a public key or script that can be given to a counterparty with the intent
of receiving funds. There are two types of outputs currently defined for witness version 0:
Pay-to-Witness-Pubkeyhash has a 20 byte hash of a public key and can be spent if the owner
reveals the public key and provides a signature from the corresponding private key.
Pay-to-Witness-Scripthash has a 32 byte hash of a script and can be spent if the owner
reveals the script along with any additional data required to satisfy the script.


**Wallet: rpc selectwallet vs --id=...**

The wallet RPC module is STATEFUL, and is always focused on one single wallet.
On boot, the `primary` wallet and its `default` account are the target of all
wallet RPC calls. To switch wallets, the client must call [rpc selectwallet <wallet>](#selectwallet)
before making the command for that specific wallet.

The wallet HTTP module is NOT stateful, meaning API calls can target any wallet,
specified on-the-fly by adding the command line argument `--id=<wallet>`

**Wallet: recovery**

There are [known issues](https://github.com/bcoin-org/bcoin/issues/835) with the hsd
wallet that may make wallet recovery difficult in some cases. The fact that addresses can
be imported (or "watched") adds to the [possible failure states](https://github.com/handshake-org/hsd/issues/218)
during recovery.

In addition, Handshake wallet users should be careful when recovering a wallet
that is bidding on in-progress auctions. Because BIDs are BLINDED on the blockchain,
they can not be recovered using the BIP44 process (which is computed exclusively with
a seed phrase plus blockchain data). [This issue is well-known](https://github.com/handshake-org/hsd/issues/378)
and some solutions have been proposed to assist in wallet recovery of blinded bid data.

<aside class="notice">
In hsd balances, <code>confirmed</code> refers to the total balance of coins
confirmed in the blockchain. <code>unconfirmed</code> refers to that total
IN ADDITION to any transactions still unconfirmed in the mempool.
Another way to think about it is your <code>unconfirmed</code> balance is the
FUTURE total value of your wallet after everything is confirmed.
</aside>

# Authentication
## Auth

```shell--curl
# default regtest port is 14037 (may be reconfigured by user), API key is required in URL
curl http://x:api-key@127.0.0.1:14037/
```

```shell--cli
cli --api-key=api-key --network=regtest info

# store API key and network type in environment variables:
export HSD_API_KEY=api-key
export HSD_NETWORK=regtest
cli info
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

// network type derived from hsd object, client object stores API key
const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const clientinfo = await client.getInfo();
  console.log(clientinfo);
})();
```

> Make sure to replace `api-key` with your own key.

Auth is accomplished via HTTP Basic Auth, using your node's API key.


<aside class="notice">
You must replace <code>api-key</code> with your own, strong API key.<br>
<br>
A good way to generate a strong key is to use the <code>bcrypto</code> module that is installed as a 
dependency for <code>hsd</code>. From your hsd directory (or anywhere, if <code>bcrypto</code> is installed globally), run:<br>
<code>node -e "bcrypto=require('bcrypto'); console.log(bcrypto.random.randomBytes(32).toString('hex'))"</code><br>
Which will generate and output a securely random, 32-byte hex string.<br>
This string could be saved in <code>hsd.conf</code> to persist over restarts, or it may be passed to hsd
at launch (for example):<br>
<code>hsd --api-key=92ded8555d6f04e440ba540f2221349cbf799c454f7e08d3f16577d3e0127b0e</code><br>
<br>
For more information about <code>hsd.conf</code> and other launch parameters, see this
<a href="https://handshake-org.github.io/guides/config.html">hsd Configuration Guide</a>.
</aside>

<aside class="warning">
If you intend to use API via network and setup <code>api-key</code>, make sure to setup <code>ssl</code> too.
</aside>
