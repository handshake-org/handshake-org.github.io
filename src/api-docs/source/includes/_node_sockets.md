# Node Sockets

## Node sockets - bsock

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const {ChainEntry, TX} = require('hsd');
const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

// Authenticate and subscribe to channels after connection
nodeSocket.on('connect', async () => {
  // Auth
  await nodeSocket.call('auth', '<api-key>');

  // Subscribe to chain events to listen for blocks
  await nodeSocket.call('watch chain');

  // Subscribe to mempool events to listen for transactions
  await nodeSocket.call('watch mempool');
});

// Listen for new blocks -- from chain channel
nodeSocket.bind('chain connect', (raw) => {
  console.log('Node -- Chain Connect Event:\n', ChainEntry.fromRaw(raw));
});

// Listen for new transactions -- from mempool channel (bloom filter required)
nodeSocket.bind('tx', (raw) => {
  console.log('Node -- TX Event:\n', TX.fromRaw(raw));
});
```

### Node Socket Authentication

Authentication with the API server must be completed before any other events
will be accepted.

### Joining a channel

Instead of joining wallets, the node server offers two "channels" of events:
`chain` and `mempool`. When the node has no mempool (for example in SPV mode)
transaction events will be relayed from the pool of peers instead. In both
channels, transactions are only returned if they match a bloom filter sent in
advance (see [set filter](#set-filter)).

### Listening for events

Unlike the wallet events, data returned by node events are not converted into
JSON format. The results are raw Buffers or arrays of Buffers. Be sure to observe
how the examples use library modules from hsd and `fromRaw()` methods to recreate
the objects. The only exception to this is [`get name`](#get-name).

### Making calls

The node socket server can also respond to more calls than the wallet socket
server.


## Node sockets - hs-client

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const {NodeClient} = require('hs-client');
const {Network, ChainEntry} = require('hsd');
const network = Network.get('regtest');

const nodeOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: '<api-key>'
}

const nodeClient = new NodeClient(nodeOptions);

(async () => {
  // Connection and both channel subscriptions handled by opening client
  await nodeClient.open();
})();

// Listen for new blocks
nodeClient.bind('chain connect', (raw) => {
  console.log('Node -- Chain Connect Event:\n', ChainEntry.fromRaw(raw));
});
```

`hs-client` abstracts away the connection, subscription, and authentication steps
to make listening for events much easier.

## Node sockets - Calls

## `watch chain`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

nodeSocket.on('connect', async () => {
  // Auth
  await nodeSocket.call('auth', '<api-key>');

  // Subscribe to chain events to listen for blocks
  await nodeSocket.call('watch chain');
});
```

Subscribe to chain events:

[`chain connect`](#chain-connect)

[`block connect`](#block-connect)

[`chain disconnect`](#chain-disconnect)

[`block disconnect`](#block-disconnect)

[`chain reset`](#chain-reset)

Unsubscribe by calling `unwatch chain`.


## `watch mempool`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

nodeSocket.on('connect', async () => {
  // Auth
  await nodeSocket.call('auth', '<api-key>');

  // Subscribe to chain events to listen for blocks
  await nodeSocket.call('watch mempool');
});
```

Subscribe to mempool/pool events:

[`tx`](#node-tx)

Unsubscribe by calling `unwatch mempool`.

##  `set filter`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const {Address} = require('hsd');
const {BloomFilter} = require('bfilter');

const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

(async () => {
  // Authentication required

  // Create new Bloom filter with standard false-positive parameters
  const filter = BloomFilter.fromRate(20000, 0.001, BloomFilter.flags.ALL);

  // Add address hash to Bloom filter
  const addr = Address.fromString('rs1qyf5f64rz9e5ngz3us34s0lm22wez5vjlmv8zp5', 'regtest');
  filter.add(addr.getHash());

  // Send the entire serialized BloomFilter to server.
  nodeSocket.call('set filter', filter.encode());
})();
```

Load a bloom filter to the node socket server. Only transactions matching the filter
will be returned. Applies to node [`tx`](#node-tx) events and the array
of transactions returned by the [`block connect`](#block-connect) event.

##  `add filter`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const {Address} = require('hsd');
const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

(async () => {
  // Authentication required
  // Bloom filter set required

  // Get address hash
  const addr = Address.fromString('rs1qd0h7e4v7snllsn77z6czsmt70mg6t2zd3zvvph', 'regtest');

  // Send to server to add to filter.
  nodeSocket.call('add filter', [addr.getHash()]);
})();
```

Add an array of Buffers to the existing Bloom filter. [`set filter`](#set-filter)
required in advance.

##  `reset filter`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

(async () => {
  // Authentication required
  // Bloom filter set required

  nodeSocket.call('reset filter');
})();
```

Resets the Bloom filter on the server to an empty buffer.

##  `get tip`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const {ChainEntry} = require('hsd');

const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

(async () => {
  // Authentication required

  const tip = nodeSocket.call('get tip');
  console.log(ChainEntry.fromRaw(tip));
})();
```

Returns the chain tip.

##  `get entry`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const {ChainEntry} = require('hsd');

const bsock = require('bsock');
const nodeSocket = bsock.connect('<regtest node RPC port>');

(async () => {
  // Authentication required

  // Get the regtest genesis block by its hash
  const hash = Buffer.from('0d01d7d33445511df6b6db9c17ada717a91b5fa557d057befd29d26701d4b8a2', 'hex')
  const entryByHash = await nodeSocket.call('get entry', hash);
  console.log(ChainEntry.fromRaw(entryByHash));

  // Get block at height 5
  const entryByHeight = await nodeSocket.call('get entry', 5);
  console.log(ChainEntry.fromRaw(entryByHeight));
})();
```

Returns a chain entry requested by block hash or by integer height.
No response if entry is not found.

##  `get hashes`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

(async () => {
  // Authentication required

  // Get all block hashes from height 10 through 20
  const hashes = await nodeSocket.call('get hashes', 10, 20);
  console.log(hashes);
})();
```

Returns an array of block hashes (as Buffers) in the specified range of height
(inclusive).

##  `estimate fee`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

(async () => {
  // Authentication required

  // Request fee estimation for inclusion within 6 blocks
  const estimate = await nodeSocket.call('estimate fee', 6);
  console.log(estimate);
})();
```

Returns an estimated fee rate (in dollarydoos per kB) necessary to include a
transaction in the specified number of blocks.

##  `send`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<network node RPC port>');

(async () => {
  // Authentication required

  // Send raw transaction
  const rawtx = Buffer.from(
    '00000000018694b6d98ed016fc7aef12c6c446ebcd11040ca8d0c6b3e8b7d22c50aa3ad' +
    '71e01000000ffffffff02a086010000000000001422689d54622e69340a3c846b07ff6a' +
    '53b22a325f0000e070327700000000001425852d90b0001a267d5b8afc64c31515bef9b' +
    '8b40000000000000241fa7e967813812156527829358ea76b3e0940b3399634147f812a' +
    'f3346c30768439b427e493e0d7b10caf3be8bb84a5d7a286d6cfa0683230ca69263c388' +
    'fcc8d012102252b10247d1ce7c0505f96e3d633e4ba4b444f3cb5cd04d1b4191459b1c1' +
    'b8e4',
    'hex'
  );
  nodeSocket.call('send', rawtx);
})();
```

Send a raw transaction (as Buffer) to node server to broadcast. Server will attempt
to broadcast the transaction without any checks.

## `send claim`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<regtest node RPC port>');

(async () => {
  // Authentication required


  // Send claim to be broadcast
  await nodeSocket.call('send claim', <Raw buffer of claim>);
})();
```

Send a raw claim transaction (as Buffer) to node to broadcast.


## `get name`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<regtest node RPC port>');

(async () => {
  // Authentication required


  // Get information for the name `hello` by passing its sha3 hash as a Buffer
  const info = await nodeSocket.call(
    'get name',
    Buffer.from(
      '3338be694f50c5f338814986cdf0686453a888b84f424d792af4b9202398f392',
      'hex'
    )
  );
  console.log(info)
})();
```

> Example:

```
{ 
  name: 'hello',
  nameHash:
   '3338be694f50c5f338814986cdf0686453a888b84f424d792af4b9202398f392',
  state: 'CLOSED',
  height: 222,
  renewal: 252,
  owner:
   { hash:
      '4e6c03cc8e5d779457f751603fbcf0518dc97cd284ee6fb131aeb2142e9cb4e1',
     index: 0 },
  value: 0,
  highest: 10000000,
  data: '0000000105776f726c640d0180',
  transfer: 0,
  revoked: 0,
  claimed: 0,
  renewals: 0,
  registered: true,
  expired: false,
  weak: false,
  stats:
   { renewalPeriodStart: 252,
     renewalPeriodEnd: 5252,
     blocksUntilExpire: 4990,
     daysUntilExpire: 34.65 } 
}
```

Get namestate of a name, given its sha3 hash as a Buffer. This is the ONLY node server
socket call that conviniently converts the return value to JSON.


##  `rescan`

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const nodeSocket = bsock.connect('<regtest node RPC port>');

// Establish a socket hook to process the filter-matched blocks and transactions
nodeSocket.hook('block rescan', (entry, txs) => {
  // Do something (like update your wallet DB)
});

(async () => {
  // Authentication required
  // Bloom filter set required

  // Rescan the blockchain from height 5
  const entry = await nodeSocket.call('rescan', 5);
})();
```

Rescan the chain from the specified integer height OR block
hash (as Buffer). Requires Bloom filter. Returns a call _back to the client_
after scanning each block:

`socket.call('block rescan', block, txs)`

Where `block` is a raw `ChainEntry` and `txs` is an array of filter-matched
transactions (as Buffers).

Note that this is NOT a wallet rescan, but the returned data can be used by a
client-side wallet to update its state.

## Node sockets - Events

## `chain connect`

> Example:

```
# ChainEntry.fromRaw(raw)
{
  hash: '6bd658d12d78eb0beeae433eac4260a0869ec148d41faa99a4ae4bda22395b58',
  height: 232,
  version: '10000000',
  prevBlock: '70aa2e0562b1d56205affac0d46617d27b1e1363a8ff488a4f60e2172f0c6a25',
  merkleRoot: '76ca3bc6c5a3e6e7a5fdb5866e3b10875a93fe34718d0a7bfa47c6af5a54723e',
  witnessRoot: '5a55edd233ae732c4dcaeb2ee0f788c8d510858c1ef23f39f195716bb6b0a23d',
  treeRoot: 'cdb49fa8353829452f0cf57dad3ef22554e223ec8d7437027e7811d5a3cb0b82',
  reservedRoot: '0000000000000000000000000000000000000000000000000000000000000000',
  time: 1580412623,
  bits: 545259519,
  nonce: 3,
  extraNonce: '000000000000000000000000000000000000000000000000',
  mask: '0000000000000000000000000000000000000000000000000000000000000000',
  chainwork: '00000000000000000000000000000000000000000000000000000000000001d2'
}
```

### Channel: `chain`

Emitted when a block is added to the chain. Returns raw `ChainEntry` of new
block.

## `block connect`

> Example:

```
# ChainEntry.fromRaw(raw), txs
{
  hash: '6bd658d12d78eb0beeae433eac4260a0869ec148d41faa99a4ae4bda22395b58',
  height: 232,
  version: '10000000',
  prevBlock: '70aa2e0562b1d56205affac0d46617d27b1e1363a8ff488a4f60e2172f0c6a25',
  merkleRoot: '76ca3bc6c5a3e6e7a5fdb5866e3b10875a93fe34718d0a7bfa47c6af5a54723e',
  witnessRoot: '5a55edd233ae732c4dcaeb2ee0f788c8d510858c1ef23f39f195716bb6b0a23d',
  treeRoot: 'cdb49fa8353829452f0cf57dad3ef22554e223ec8d7437027e7811d5a3cb0b82',
  reservedRoot: '0000000000000000000000000000000000000000000000000000000000000000',
  time: 1580412623,
  bits: 545259519,
  nonce: 3,
  extraNonce: '000000000000000000000000000000000000000000000000',
  mask: '0000000000000000000000000000000000000000000000000000000000000000',
  chainwork: '00000000000000000000000000000000000000000000000000000000000001d2'
}

[
  <Buffer 00 00 00 00 01 00 00 00 ff ff ff ff 33 4d 8b 58 01 00 94 35 77 ... >
]
```

### Channel: `chain`

Emitted when a block is added to the chain. Returns raw `ChainEntry` of new
block. If a [Bloom filter has been loaded in advance](#set-filter),
this call will also return an array of filter-matching transactions (as raw
Buffers).

## `chain disconnect`

> Example:

```
# ChainEntry.fromRaw(raw)
{
  hash: '6bd658d12d78eb0beeae433eac4260a0869ec148d41faa99a4ae4bda22395b58',
  height: 232,
  version: '10000000',
  prevBlock: '70aa2e0562b1d56205affac0d46617d27b1e1363a8ff488a4f60e2172f0c6a25',
  merkleRoot: '76ca3bc6c5a3e6e7a5fdb5866e3b10875a93fe34718d0a7bfa47c6af5a54723e',
  witnessRoot: '5a55edd233ae732c4dcaeb2ee0f788c8d510858c1ef23f39f195716bb6b0a23d',
  treeRoot: 'cdb49fa8353829452f0cf57dad3ef22554e223ec8d7437027e7811d5a3cb0b82',
  reservedRoot: '0000000000000000000000000000000000000000000000000000000000000000',
  time: 1580412623,
  bits: 545259519,
  nonce: 3,
  extraNonce: '000000000000000000000000000000000000000000000000',
  mask: '0000000000000000000000000000000000000000000000000000000000000000',
  chainwork: '00000000000000000000000000000000000000000000000000000000000001d2'
}
```

### Channel: `chain`

Emitted when a block is removed from the chain. Returns raw `ChainEntry` of the
block being removed.

## `block disconnect`

Identical to [`chain disconnect`](#chain-disconnect)

## `chain reset`

> Example:

```
# ChainEntry.fromRaw(raw)
{
  hash: '6bd658d12d78eb0beeae433eac4260a0869ec148d41faa99a4ae4bda22395b58',
  height: 232,
  version: '10000000',
  prevBlock: '70aa2e0562b1d56205affac0d46617d27b1e1363a8ff488a4f60e2172f0c6a25',
  merkleRoot: '76ca3bc6c5a3e6e7a5fdb5866e3b10875a93fe34718d0a7bfa47c6af5a54723e',
  witnessRoot: '5a55edd233ae732c4dcaeb2ee0f788c8d510858c1ef23f39f195716bb6b0a23d',
  treeRoot: 'cdb49fa8353829452f0cf57dad3ef22554e223ec8d7437027e7811d5a3cb0b82',
  reservedRoot: '0000000000000000000000000000000000000000000000000000000000000000',
  time: 1580412623,
  bits: 545259519,
  nonce: 3,
  extraNonce: '000000000000000000000000000000000000000000000000',
  mask: '0000000000000000000000000000000000000000000000000000000000000000',
  chainwork: '00000000000000000000000000000000000000000000000000000000000001d2'
}
```

### Channel: `chain`

Returns raw `ChainEntry` of the new current tip.


## Node `tx`

> Example:

```
 # TX.fromRaw(raw)
{ 
  hash:
   'd3f31c0f86f563daf1413570b04b26e39e0a011ed87be16dce31db1237bde14b',
  witnessHash:
   'a852e21c16f389aa6d503fcb6fe58cde09c94a2aa3553382c549c4b0e74fc28e',
  size: 215,
  virtualSize: 140,
  value: '1999.8944',
  fee: '0.0',
  rate: '0.0',
  minFee: '0.00014',
  height: -1,
  block: null,
  time: 0,
  date: null,
  index: -1,
  version: 0,
  inputs:
   [ { address:
        <Address: version=0 str=hs1q52kcp6yn2wg7vpakjmjf648sq8zxaklr002pgx>,
       prevout:
        <Outpoint: 8694b6d98ed016fc7aef12c6c446ebcd11040ca8d0c6b3e8b7d22c50aa3ad71e/1>,
       witness:
        <Witness: fa7e967813812156527829358ea76b3e0940b3399634147f812af3346c30768439b427e493e0d7b10caf3be8bb84a5d7a286d6cfa0683230ca69263c388fcc8d01 02252b10247d1ce7c0505f96e3d633e4ba4b444f3cb5cd04d1b4191459b1c1b8e4>,
       sequence: 4294967295,
       coin: null } ],
  outputs:
   [ { value: '0.1',
       address:
        <Address: version=0 str=hs1qyf5f64rz9e5ngz3us34s0lm22wez5vjlckeppx>,
       covenant: <Covenant: 0:00> },
     { value: '1999.7944',
       address:
        <Address: version=0 str=hs1qykzjmy9sqqdzvl2m3t7xfsc4zkl0nw95pce92z>,
       covenant: <Covenant: 0:00> } ],
  locktime: 0
}
```

### Channel: `mempool`

Emitted when a transaction that matches a previously set Bloom filter is received
by the node server. Returns transaction as raw Buffer.
