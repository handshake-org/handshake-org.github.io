# hsd - Node

## hsd client requests

Complete list of commands:

Command     				|cURL method	| Description
----------------------------|---------------|------------
[`/`](#get-server-info)							| `GET`			| get info
[`/coin/address/:address`](#get-coins-by-address)	| `GET`			| UTXO by address
[`/coin/:hash/:index`](#get-coin-by-outpoint)		| `GET`			| UTXO by txid
[`/coin/address`](#get-coins-by-addresses)				| `POST`		| Bulk read UTXOs
[`/tx/:hash`](#get-tx-by-txhash)				| `GET`			| TX by hash
[`/tx/address/:address`](#get-tx-by-address)		| `GET`			| TX by address
[`/tx/address`](#get-tx-by-addresses)				| `POST`		| Bulk read TXs
[`/block/:block`](#get-block-by-hash-or-height)			| `GET`			| Block by hash or height
[`/mempool`](#get-mempool-snapshot)					| `GET`			| Mempool snapshot
[`/mempool/invalid`](#get-mempool-rejects-filter)         | `GET`     | Mempool rejects filter
[`/mempool/invalid/:hash`](#test-mempool-rejects-filter)         | `GET`     | Test mempool rejects filter
[`/broadcast`](#broadcast-transaction)				| `POST`		| Broadcast TX
[`/claim`](#broadcast-claim)        | `POST`    | Broadcast Claim
[`/fee`](#estimate-fee)						| `GET`			| Estimate fee
[`/reset`](#reset-blockchain)					| `POST`		| Reset chain to specific height



## Get server info

```shell--curl
curl $url/
```

```shell--cli
hsd-cli info
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

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

> The above command returns JSON structured like this:

```json
{
  "version": "2.0.1",
  "network": "regtest",
  "chain": {
    "height": 1,
    "tip": "6b054a7a561fdfa7c2f11550db4d5341d101be044df24dd58c465b2abac94c3f",
    "treeRoot": "0000000000000000000000000000000000000000000000000000000000000000",
    "progress": 0.6125905181398805,
    "state": {
      "tx": 2,
      "coin": 1360,
      "value": 237416588368270,
      "burned": 0
    }
  },
  "pool": {
    "host": "0.0.0.0",
    "port": 14038,
    "identitykey": "aorsxa4ylaacshipyjkfbvzfkh3jhh4yowtoqdt64nzemqtiw2whk",
    "agent": "/hsd:2.0.1/",
    "services": "1",
    "outbound": 0,
    "inbound": 0
  },
  "mempool": {
    "tx": 0,
    "size": 0,
    "claims": 0,
    "airdrops": 0,
    "orphans": 0
  },
  "time": {
    "uptime": 3,
    "system": 1581299165,
    "adjusted": 1581299165,
    "offset": 0
  },
  "memory": {
    "total": 78,
    "jsHeap": 11,
    "jsHeapTotal": 29,
    "nativeHeap": 49,
    "external": 14
  }
}
```

Get server Info.

### HTTP Request
<p>Get server info. No params.</p>

`GET /`

 No Params.


## Get mempool snapshot

```shell--curl
curl $url/mempool
```

```shell--cli
hsd-cli mempool
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const mempool = await client.getMempool();
  console.log(mempool);
})().catch((err) => {
  console.error(err.stack);
});
```

> The above command returns JSON structured like this:

```json
[
  "2ef8051e6c38e136ba4d195c048e78f9077751758db710475fa532b9d9489324",
  "bc3308b61959664b71ac7fb8e9ee17d13476b5a32926f512882851b7631884f9",
  "53faa103e8217e1520f5149a4e8c84aeb58e55bdab11164a95e69a8ca50f8fcc",
  "fff647849be7408faedda377eea6c37718ab39d656af8926e0b4b74453624f32",
  "b3c71dd8959ea97d41324779604b210ae881cdaa5d5abfcbfb3502a0e75c1283",
  ...
]
```

Get mempool snapshot (array of json txs).

### HTTP Request
`GET /mempool`

No Params.


## Get mempool rejects filter

```shell--curl
curl $url/mempool/invalid
```

```shell--cli
> no CLI command available
```

```javascript
// no JS client function available
```

> The above command returns JSON structured like this:

```json
{
  "items": 161750,
  "size": 5175951,
  "entries": 0,
  "n": 20,
  "limit": 60000,
  "tweak": 3433901487
}
```

Get mempool rejects filter (a Bloom filter used to store rejected TX hashes).

### HTTP Request
`GET /mempool/invalid`

### URL Parameters

Parameter | Description
--------- | -----------
verbose | _(bool)_ Returns entire Bloom Filter in `filter` property, hex-encoded.


## Test mempool rejects filter

```shell--curl
hash=8e4c9756fef2ad10375f360e0560fcc7587eb5223ddf8cd7c7e06e60a1140b15
curl $url/mempool/invalid/$hash
```

```shell--cli
> no CLI command available
```

```javascript
// no JS client function available
```

> The above command returns JSON structured like this:

```json
{
  "invalid": false
}
```

Test a TX hash against the mempool rejects filter.

### HTTP Request
`GET /mempool/invalid/:hash`

### URL Parameters

Parameter | Description
--------- | -----------
:hash | Transaction hash


## Get block by hash or height

```javascript
let blockHash, blockHeight;
```

```shell--vars
blockHash='ae3895cf597eff05b19e02a70ceeeecb9dc72dbfe6504a50e9343a72f06a87c5';
blockHeight='0';
```

```shell--curl
curl $url/block/$blockHash # by hash
curl $url/block/$blockHeight # by height
```

```shell--cli
hsd-cli block $blockHash # by hash
hsd-cli block $blockHeight # by height
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const blockByHeight = await client.getBlock(blockHeight);
  const blockByHash = await client.getBlock(blockHash);
  console.log("By height: \n", blockByHeight);
  console.log("By hash: \n", blockByHash);
})();
```

> The above command returns JSON structured like this:

```json
{
  "hash": "ae3895cf597eff05b19e02a70ceeeecb9dc72dbfe6504a50e9343a72f06a87c5",
  "height": 0,
  "depth": 2,
  "version": 0,
  "prevBlock": "0000000000000000000000000000000000000000000000000000000000000000",
  "merkleRoot": "8e4c9756fef2ad10375f360e0560fcc7587eb5223ddf8cd7c7e06e60a1140b15",
  "witnessRoot": "1a2c60b9439206938f8d7823782abdb8b211a57431e9c9b6a6365d8d42893351",
  "treeRoot": "0000000000000000000000000000000000000000000000000000000000000000",
  "reservedRoot": "0000000000000000000000000000000000000000000000000000000000000000",
  "time": 1580745080,
  "bits": 545259519,
  "nonce": 0,
  "extraNonce": "000000000000000000000000000000000000000000000000",
  "mask": "0000000000000000000000000000000000000000000000000000000000000000",
  "txs": [
    {
      "hash": "9553240e6f711271cfccf9407c9348996e61cb3bd39adbc2ec258ff940ff22c6",
      "witnessHash": "49880b0f9dd1b0b5dd43f6d64803276d54717e5f98b71d82bf170cb4dd0c2388",
      "fee": 0,
      "rate": 0,
      "mtime": 1581299280,
      "index": 0,
      "version": 0,
      "inputs": [
        {
          "prevout": {
            "hash": "0000000000000000000000000000000000000000000000000000000000000000",
            "index": 4294967295
          },
          "witness": [
            "50b8937fc5def08f9f3cbda7e5f08c706edb80aba5880c000000000000000000",
            "2d5de58609d4970fb548f85ad07a87db40e054e34cc81c951ca995a58f674db7",
            "10d748eda1b9c67b94d3244e0211677618a9b4b329e896ad90431f9f48034bad",
            "e2c0299a1e466773516655f09a64b1e16b2579530de6c4a59ce5654dea45180f"
          ],
          "sequence": 4294967295,
          "address": null
        }
      ],
      "outputs": [
        {
          "value": 2002210000,
          "address": "rs1q7q3h4chglps004u3yn79z0cp9ed24rfrhvrxnx",
          "covenant": {
            "type": 0,
            "action": "NONE",
            "items": []
          }
        }
      ],
      "locktime": 0,
      "hex": "00000000010000000000000000000000000000000000000000000000000000000000000000ffffffffffffffff01d04c5777000000000014f0237ae2e8f860f7d79124fc513f012e5aaa8d23000000000000042050b8937fc5def08f9f3cbda7e5f08c706edb80aba5880c000000000000000000202d5de58609d4970fb548f85ad07a87db40e054e34cc81c951ca995a58f674db72010d748eda1b9c67b94d3244e0211677618a9b4b329e896ad90431f9f48034bad20e2c0299a1e466773516655f09a64b1e16b2579530de6c4a59ce5654dea45180f"
    }
  ]
}
```

Returns block info by block hash or height.

### HTTP Request
`GET /block/:blockhashOrHeight`


### URL Parameters

Parameter | Description
--------- | -----------
:blockhashOrHeight | Hash or Height of block


## Broadcast transaction
```javascript
let tx;
```

```shell--vars
tx='010000000106b014e37704109fefe2c5c9f4227d68840c3497fc89a9832db8504df039a6c7000000006a47304402207dc8173fbd7d23c3950aaf91b1bc78c0ed9bf910d47a977b24a8478a91b28e69022024860f942a16bc67ec54884e338b5b87f4a9518a80f9402564061a3649019319012103cb25dc2929ea58675113e60f4c08d084904189ab44a9a142179684c6cdd8d46affffffff0280c3c901000000001976a91400ba915c3d18907b79e6cfcd8b9fdf69edc7a7db88acc41c3c28010000001976a91437f306a0154e1f0de4e54d6cf9d46e07722b722688ac00000000';
```

```shell--curl
curl $url/broadcast \
  -H 'Content-Type: application/json' \
  -X POST \
  --data '{ "tx": "'$tx'" }'
```

```shell--cli
hsd-cli broadcast $tx
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.broadcast(tx);
  console.log(result);
})();
```

> The above command returns JSON structured like this:

```json
{
  "success": true
}
```

Broadcast a transaction by adding it to the node's mempool. If mempool verification fails, the node will still forcefully advertise and relay the transaction for the next 60 seconds.

### HTTP Request
`POST /broadcast`

### POST Parameters (JSON)
Parameter | Description
--------- | -----------
tx | raw transaction in hex


## Broadcast claim
```javascript
let claim;
```

```shell--vars
claim='310d030300003000010002a30001080101030803010001acffb409bcc939f...';
```

```shell--curl
curl $url/claim \
  -H 'Content-Type: application/json' \
  -X POST \
  --data '{ "claim": "'$claim'" }'
```

```shell--cli
> no CLI command available
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.broadcastClaim(claim);
  console.log(result);
})();
```

> The above command returns JSON structured like this:

```json
{
  "success": true
}
```

Broadcast a claim by adding it to the node's mempool.

### HTTP Request
`POST /claim`

### POST Parameters (JSON)
Parameter | Description
--------- | -----------
claim | raw claim in hex


## Estimate fee
```javascript
let blocks;
```

```shell--vars
blocks=3
```

```shell--curl
curl $url/fee?blocks=$blocks
```

```shell--cli
hsd-cli fee $blocks
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.estimateFee(blocks);
  console.log(result);
})();
```

> The above command returns JSON structured like this:

```json
{
  "rate": 13795
}
```

Estimate the fee required (in dollarydoos per kB) for a transaction to be confirmed by the network within a targeted number of blocks (default 1).

### HTTP Request
`GET /fee`

### GET Parameters
Parameter | Description
--------- | -----------
blocks | Number of blocks to target confirmation


## Reset blockchain
```javascript
let height;
```

```shell--vars
height=1000;
```

```shell--curl
curl $url/reset \
  -H 'Content-Type: application/json' \
  -X POST \
  --data '{ "height": '$height' }'
```

```shell--cli
hsd-cli reset $height
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.reset(height);
  console.log(result);
})();
```

> The above command returns JSON structured like this:

```json
{
  "success": true
}
```

Triggers a hard-reset of the blockchain. All blocks are disconnected from the tip
down to the provided height. Indexes and Chain Entries are removed. Useful for
"rescanning" an SPV wallet. Since there are no blocks stored on disk, the only
way to rescan the blockchain is to re-request [merkle]blocks from peers.

### HTTP Request
`POST /reset`

### POST Parameters (JSON)
Parameter | Description
--------- | -----------
height | block height to reset chain to 

