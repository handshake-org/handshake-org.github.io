# Events and Sockets

To listen for and react to events in hsd, a listener must be added in the runtime script.
If you are running a full node (for example) you might already be familiar with [the hsd
full node launch script](https://github.com/handshake-org/hsd/blob/master/bin/node), which
instantiates a `FullNode` object, adds a wallet, and begins the connection and synchronization process.
The script ends with an `async` function that actually starts these processes, and this is
a good place to add event listeners. [Using the table below](#events-directory) you can discover which object needs
to be listened `on` for each event type. Notice that because the wallet is added as a plugin,
its object hierarchy path is a little... awkward :-)

```javascript
// Based on https://github.com/handshake-org/hsd/blob/master/bin/node

(async () => {
  await node.ensure();
  await node.open();
  await node.connect();
  node.startSync();

  // add event listeners after everything is open, connected, and started

  // NODE
  node.on('tx', (details) => {
    console.log(' -- node tx -- \n', details)
  });
  
  node.on('block', (details) => {
    console.log(' -- node block -- \n', details)
  });

  // MEMPOOL
  node.mempool.on('confirmed', (details) => {
    console.log(' -- mempool confirmed -- \n', details)
  });

  // WALLET
  node.plugins.walletdb.wdb.on('balance', (details) => {
    console.log(' -- wallet balance -- \n', details)
  });

  node.plugins.walletdb.wdb.on('confirmed', (details) => {
    console.log(' -- wallet confirmed -- \n', details)
  });

  node.plugins.walletdb.wdb.on('address', (details) => {
    console.log(' -- wallet address -- \n', details)
  });

})().catch((err) => {
  console.error(err.stack);
  process.exit(1);
});
```

## Events Directory

This list is comprehensive for all Handshake transaction, wallet, and blockchain activity.
Events regarding errors, socket connections and peer connections have been omitted for clarity.
Notice that certain methods emit the same events but with different return objects,
and not all re-emitters return everything they receive.

| Event | Returns | Origin | Re-Emitters |
|-|-|-|-|
| `tip` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `open()`, `disconnect()`, `reconnect()`, `setBestChain()`, `reset()`| |
| `connect` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js), [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js), [CoinView](https://github.com/handshake-org/hsd/blob/master/lib/coins/coinview.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `setBestChain()`, `reconnect()`| _chain_&#8594;[FullNode](https://github.com/handshake-org/hsd/blob/master/lib/node/fullnode.js) (returns&nbsp;ChainEntry,&nbsp;Block&nbsp;only)<br>_chain_&#8594;[SPVNode](https://github.com/handshake-org/hsd/blob/master/lib/node/spvnode.js) (returns&nbsp;ChainEntry,&nbsp;Block&nbsp;only)<br>_SPVNode_,&nbsp;_FullNode_&#8594;[NodeClient](https://github.com/handshake-org/hsd/blob/master/lib/wallet/nodeclient.js) (emits as `block connect`, returns&nbsp;ChainEntry,&nbsp;Block.txs&nbsp;only) |
| `disconnect` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js), [Headers](https://github.com/handshake-org/hsd/blob/master/lib/primitives/headers.js), [CoinView](https://github.com/handshake-org/hsd/blob/master/lib/coins/coinview.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `reorganizeSPV()` | _chain_&#8594;[FullNode](https://github.com/handshake-org/hsd/blob/master/lib/node/fullnode.js) (returns&nbsp;ChainEntry,&nbsp;Headers&nbsp;only)<br>_chain_&#8594;[SPVNode](https://github.com/handshake-org/hsd/blob/master/lib/node/spvnode.js) (returns&nbsp;ChainEntry,&nbsp;Headers&nbsp;only)<br>_SPVNode_,&nbsp;_FullNode_&#8594;[NodeClient](https://github.com/handshake-org/hsd/blob/master/lib/wallet/nodeclient.js) (emits as `block disconnect`, returns&nbsp;ChainEntry&nbsp;only) |
| `disconnect` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js), [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js), [CoinView](https://github.com/handshake-org/hsd/blob/master/lib/coins/coinview.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `disconnect()` | _chain_&#8594;[FullNode](https://github.com/handshake-org/hsd/blob/master/lib/node/fullnode.js) (returns&nbsp;ChainEntry,&nbsp;Block&nbsp;only)<br>_chain_&#8594;[SPVNode](https://github.com/handshake-org/hsd/blob/master/lib/node/spvnode.js) (returns&nbsp;ChainEntry,&nbsp;Block&nbsp;only)<br>_SPVNode_,&nbsp;_FullNode_&#8594;[NodeClient](https://github.com/handshake-org/hsd/blob/master/lib/wallet/nodeclient.js) (emits as `block disconnect`, returns&nbsp;ChainEntry&nbsp;only) |
| `reconnect` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js), [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `reconnect()`| |
| `reorganize` | tip ([ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js)), competitor ([ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js)) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `reorganize()`, `reorganizeSPV()` | _chain_&#8594;[FullNode](https://github.com/handshake-org/hsd/blob/master/lib/node/fullnode.js)<br>_chain_&#8594;[SPVNode](https://github.com/handshake-org/hsd/blob/master/lib/node/spvnode.js) |
| `block` | [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js), [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `setBestChain()`<br>[CPUMiner](https://github.com/handshake-org/hsd/blob/master/lib/mining/cpuminer.js): `_start()`| _chain_&#8594;[Pool](https://github.com/handshake-org/hsd/blob/master/lib/net/pool.js)<br> _chain_&#8594;[FullNode](https://github.com/handshake-org/hsd/blob/master/lib/node/fullnode.js) (returns&nbsp;Block&nbsp;only)<br> _chain_&#8594;[SPVNode](https://github.com/handshake-org/hsd/blob/master/lib/node/spvnode.js) (returns&nbsp;Block&nbsp;only) |
| `competitor` | [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js), [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `saveAlternate()` | |
| `bad orphan` | Error, ID | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `handleOrphans()`<br>[Mempool](https://github.com/handshake-org/hsd/blob/master/lib/mempool/mempool.js): `handleOrphans()` | |
| `resolved` | [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js), [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `handleOrphans()` | |
| `checkpoint` | Hash, Height | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `verifyCheckpoint()` | |
| `orphan` | [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js) | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `storeOrphan()` | |
| `full` | | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js): `maybeSync()` | _chain_&#8594;[Pool](https://github.com/handshake-org/hsd/blob/master/lib/net/pool.js)|
| `confirmed` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js), [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js) | [Mempool](https://github.com/handshake-org/hsd/blob/master/lib/mempool/mempool.js): `_addBlock()`| |
| `confirmed` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js), [Details](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) | [TXDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js): `confirm()` | _txdb_&#8594;[WalletDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/walletdb.js) (also&nbsp;returns&nbsp;Wallet)<br>_txdb_&#8594;[Wallet](https://github.com/handshake-org/hsd/blob/master/lib/wallet/wallet.js)|
| `unconfirmed` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js), [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js) | [Mempool](https://github.com/handshake-org/hsd/blob/master/lib/mempool/mempool.js): `_removeBlock()`| |
| `unconfirmed` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js), [Details](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) | [TXDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js): `disconnect()` | _txdb_&#8594;[WalletDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/walletdb.js) (also&nbsp;returns&nbsp;Wallet)<br>_txdb_&#8594;[Wallet](https://github.com/handshake-org/hsd/blob/master/lib/wallet/wallet.js)|
| `conflict` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js) | [Mempool](https://github.com/handshake-org/hsd/blob/master/lib/mempool/mempool.js): `_removeBlock()`| |
| `conflict` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js), [Details](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) | [TXDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js): `disconnect()` | _txdb_&#8594;[WalletDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/walletdb.js) (also&nbsp;returns&nbsp;Wallet)<br>_txdb_&#8594;[Wallet](https://github.com/handshake-org/hsd/blob/master/lib/wallet/wallet.js)|
| `tx` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js), [CoinView](https://github.com/handshake-org/hsd/blob/master/lib/coins/coinview.js) | [Mempool](https://github.com/handshake-org/hsd/blob/master/lib/mempool/mempool.js): `addEntry()` | _mempool_&#8594;[Pool](https://github.com/handshake-org/hsd/blob/master/lib/net/pool.js) (returns&nbsp;TX&nbsp;only)<br> _mempool_&#8594;_pool_&#8594;[SPVNode](https://github.com/handshake-org/hsd/blob/master/lib/node/spvnode.js) (returns&nbsp;TX&nbsp;only)<br> _mempool_&#8594;[FullNode](https://github.com/handshake-org/hsd/blob/master/lib/node/fullnode.js) (returns&nbsp;TX&nbsp;only)<br>_SPVNode_,&nbsp;_FullNode_&#8594;[NodeClient](https://github.com/handshake-org/hsd/blob/master/lib/wallet/nodeclient.js) (returns&nbsp;TX&nbsp;only) |
| `tx` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js)| [Pool](https://github.com/handshake-org/hsd/blob/master/lib/net/pool.js): `_handleTX()`<br>(only if there is no mempool, i.e. SPV) | _pool_&#8594;[SPVNode](https://github.com/handshake-org/hsd/blob/master/lib/node/spvnode.js) |
| `tx` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js), [Details](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) | [TXDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js): `insert()` | _txdb_&#8594;[WalletDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/walletdb.js) (also&nbsp;returns&nbsp;Wallet)<br>_txdb_&#8594;[Wallet](https://github.com/handshake-org/hsd/blob/master/lib/wallet/wallet.js)|
| `double spend` | [MempoolEntry](https://github.com/handshake-org/hsd/blob/master/lib/mempool/mempoolentry.js) | [Mempool](https://github.com/handshake-org/hsd/blob/master/lib/mempool/mempool.js): `removeDoubleSpends()` | |
| `balance` | [Balance](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) | [TXDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js): `insert()`, `confirm()`, `disconnect()`, `erase()` | _txdb_&#8594;[WalletDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/walletdb.js) (also&nbsp;returns&nbsp;Wallet)<br>_txdb_&#8594;[Wallet](https://github.com/handshake-org/hsd/blob/master/lib/wallet/wallet.js)|
| `address` | [[WalletKey](https://github.com/handshake-org/hsd/blob/master/lib/wallet/walletkey.js)] | [Wallet](https://github.com/handshake-org/hsd/blob/master/lib/wallet/wallet.js): `_add()`, | _wallet_&#8594;[WalletDB](https://github.com/handshake-org/hsd/blob/master/lib/wallet/walletdb.js) (returns&nbsp;parent&nbsp;Wallet,&nbsp;[WalletKey]) |

## Socket Events

Websocket connections in hsd are handled by two servers, one for `Node` and one for `Wallet`.
Those servers each have child objects such as `Chain`, `Mempool`, `Pool`, and `WalletDB`, and
relay events from them out the socket. To receive an event, the socket client must watch a
channel (such as `chain`, `mempool`, or `auth`) or join a wallet
(which would be user-defined like `primary`, `hot-wallet`, or `multisig1`). All wallets can be
joined at once by joining `'*'`. 

### Listen for Socket Events with bsock

To make a socket connection to hsd, you need to run a websocket client.
Luckily the bcoin and hsd developers have developed [bsock](https://github.com/bcoin-org/bsock), 
a minimal websocket-only implementation of the socket.io protocol. By default, bsock listens on
`localhost`, and you only need to pass it a port number to connect to one of the hsd servers.
The example below illustrates how to establish the socket connection, authenticate with your
user-defined [API key](https://handshake-org.github.io/api-docs/#authentication) and then send and receive events!
[See the tables below for a complete list of calls and events available in hsd.](#socket-events-directory)

```javascript
// bsock-example.js

const bsock = require('bsock');
const {Network, ChainEntry} = require('hsd');
const network = Network.get('regtest');
const apiKey = 'api-key';

nodeSocket = bsock.connect(network.rpcPort);
walletSocket = bsock.connect(network.walletPort);

nodeSocket.on('connect', async (e) => {
  try {
    console.log('Node - Connect event:\n', e);

    // `auth` must be called before any other actions
    console.log('Node - Attempting auth:\n', await nodeSocket.call('auth', apiKey));

    // `watch chain` subscribes us to chain events like `block`
    console.log('Node - Attempting watch chain:\n', await nodeSocket.call('watch chain'));

    // Some calls simply request information from the server like an http request
    console.log('Node - Attempting get tip:');
    const tip = await nodeSocket.call('get tip');
    console.log(ChainEntry.from(tip));

  } catch (e) {
    console.log('Node - Connection Error:\n', e);
  } 
});

// listen for new blocks
nodeSocket.bind('chain connect', (raw, txs) => {
  console.log('Node - Chain Connect Event:\n', ChainEntry.fromRaw(raw));
});

walletSocket.on('connect', async (e) => {
  try {
    console.log('Wallet - Connect event:\n', e);

    // `auth` is required before proceeding
    console.log('Wallet - Attempting auth:\n', await walletSocket.call('auth', apiKey));

    // here we join all wallets, but we could also just join `primary` or any other wallet
    console.log('Wallet - Attempting join *:\n', await walletSocket.call('join', '*'));

  } catch (e) {
    console.log('Wallet - Connection Error:\n', e);
  } 
});

// listen for new wallet transactions
walletSocket.bind('tx', (wallet, tx) => {
  console.log('Wallet - TX Event -- wallet:\n', wallet);
  console.log('Wallet - TX Event -- tx:\n', tx);
});

// listen for new address events
// (only fired when current account address receives a transaction)
walletSocket.bind('address', (wallet, json) => {
  console.log('Wallet - Address Event -- wallet:\n', wallet);
  console.log('Wallet - Address Event -- json:\n', json);
});
```

To see this script in action, first start hsd however you usually do:

```bash
hsd --daemon --network=regtest
```

Run the script (this is where the event output will be printed):

```bash
node bsock-example.js
```

Then, in a separate terminal window, run some commands to trigger the events!

```bash
hsd-cli rpc generatetoaddress 1  rs1qyep4stuujjkdfv483nfse53vvgtfuqr9z6v4cm
```

### Sockets made easy: hs-client

`bsock` is a great low-level library for dealing with sockets, but we also have
[hs-client](https://github.com/handshake-org/hs-client) which simplifies both socket and regular http
connections. A simple one-line command in the terminal can listen to all wallet events and
print all the returned data:

```bash
hsw-cli listen
```

`hs-client` can also be used in a script to listen for events. If you're already familiar with
the [hsd-cli API](https://handshake-org.github.io/api-docs) this will look very familiar. Here's part of the
script above re-written using `hs-client` instead of `bsock`:

```javascript
const {NodeClient} = require('hs-client');
const {Network, ChainEntry} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}
const client = new NodeClient(clientOptions);

(async () => {
  // bclient handles the connection, the auth, and the channel subscriptions
  await client.open();

  // use socket connection to request data
  const tip = await client.getTip();
  console.log(tip);
})();

// listen for new blocks
client.bind('chain connect', (raw) => {
  console.log('Node - Chain Connect Event:\n', ChainEntry.fromRaw(raw));
});
```


## Socket Events Directory

### Wallet

All wallet events are emitted by a `WalletDB` object, which may have been triggered by its parent
`TXDB` or `Wallet`. The socket emits the event along with the wallet ID, and the same "Returns" as listed above.

| Event | Returns |
|-|-|
| `tx` | WalletID, [TX Details](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) |
| `confirmed` | WalletID, [TX Details](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) |
| `unconfirmed` | WalletID, [TX Details](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) |
| `conflict` | WalletID, [TX Details](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js)|
| `balance` | WalletID, [Balance](https://github.com/handshake-org/hsd/blob/master/lib/wallet/txdb.js) |
| `address` | WalletID, [[WalletKey](https://github.com/handshake-org/hsd/blob/master/lib/wallet/walletkey.js)] |

### Node

| Event | Returns | Channel | Origin | Original Event |
|-|-|-|-|-|
| `chain connect` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js)_.toRaw()_ | `chain` | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js) | `connect` |
| `block connect` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js)_.toRaw()_, [Block](https://github.com/handshake-org/hsd/blob/master/lib/primitives/block.js)_.txs_ | `chain` | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js) | `connect` |
| `chain disconnect` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js)_.toRaw()_ | `chain` | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js) | `disconnect` |
| `block disconnect` | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js)_.toRaw()_ | `chain` | [Chain](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js) | `disconnect` |
| `tx ` | [TX](https://github.com/handshake-org/hsd/blob/master/lib/primitives/tx.js)_.toRaw()_ | `mempool` | [Pool](https://github.com/handshake-org/hsd/blob/master/lib/net/pool.js) | `tx` |

## Server Hooks

Certain events can also be sent back to the server from the client to request new data
or trigger a server action. The client action is a "call" and the server waits with a "hook".

### Wallet

| Event | Args | Returns |
|-|-|-|
| `auth` | 1. _api key_ | _null_ |
| `join` | 1. _wallet id_ <br>2. _wallet token_ | _null_ |
| `leave` | 1. _wallet id_ | _null_ |

### Node

| Event | Args | Returns |
|-|-|-|
| `auth` | 1. _api key_ | _null_ |
| `watch chain` | (none) | _null_ |
| `unwatch chain` | (none) | _null_ |
| `watch mempool` | (none) | _null_ |
| `unwatch mempool` | (none) | _null_ |
| `set filter` | 1. _Bloom filter_ (Buffer)| _null_ |
| `get tip` | (none) | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js)_.toRaw()_ |
| `get entry` | 1. _hash_ | [ChainEntry](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chainentry.js)_.toRaw()_ |
| `get hashes` | 1. _start_ (int)<br>2. _end_ (int) | [hashes] |
| `add filter` | 1. _filter_ ([Buffer]) | _null_ |
| `reset filter` | (none) | _null_ |
| `estimate fee` | 1. _blocks_ (int) | _fee rate_ (float) |
| `send` | 1. _tx_ (Buffer) | _null_ |
| `rescan` | 1. _hash_ | _null_ |
