# hsd - Node

## hsd client requests

Complete list of commands:

Command     				|cURL method	| Description
----------------------------|---------------|------------
`/`							| `GET`			| get info
`/coin/address/:address`	| `GET`			| UTXO by address
`/coin/:hash/:index`		| `GET`			| UTXO by txid
`/coin/address`				| `POST`		| Bulk read UTXOs
`/tx/:hash`					| `GET`			| TX by hash
`/tx/address/:address`		| `GET`			| TX by address
`/tx/address`				| `POST`		| Bulk read TXs
`/block/:block`				| `GET`			| Block by hash or height
`/mempool`					| `GET`			| Mempool snapshot
`/broadcast`				| `POST`		| Broadcast TX
`/fee`						| `GET`			| Estimate fee
`/reset`					| `POST`		| Reset chain to specific height



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
  "version": "0.0.0",
  "network": "regtest",
  "chain": {
    "height": 205,
    "tip": "38d4ff72bca6737d958e1456be90443c0e09186349f28b952564118ace222331",
    "progress": 1
  },
  "pool": {
    "host": "18.188.224.12",
    "port": 14038,
    "agent": "/hsd:0.0.0/",
    "services": "1001",
    "outbound": 1,
    "inbound": 1
  },
  "mempool": {
    "tx": 0,
    "size": 0
  },
  "time": {
    "uptime": 1744,
    "system": 1527028546,
    "adjusted": 1527028546,
    "offset": 0
  },
  "memory": {
    "total": 90,
    "jsHeap": 19,
    "jsHeapTotal": 26,
    "nativeHeap": 64,
    "external": 9
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


## Get block by hash or height

```javascript
let blockHash, blockHeight;
```

```shell--vars
blockHash='ae99a76a7de09b955515014d632e70af82e504dab9f8278387ffd0d6a4caa890';
blockHeight='1';
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
  "hash": "ae99a76a7de09b955515014d632e70af82e504dab9f8278387ffd0d6a4caa890",
  "height": 1,
  "depth": 2,
  "version": 0,
  "prevBlock": "695e315d274ec2de4d050ef63d497a2cbaf8103bbed0c559d5ac45d840015be5",
  "merkleRoot": "7d142b878b7894fb916280d0bee0b5c4f8970e1adbc9d1a2e9057a0b8187b709",
  "witnessRoot": "2521e8ab766ec523a97c6f0acb48d36b5b0684dc5e1cfd5e3cd703eb2d8386e8",
  "treeRoot": "0000000000000000000000000000000000000000000000000000000000000000",
  "time": 1528315264,
  "bits": 545259519,
  "nonce": "0400000000000000000000000000000000000000",
  "solution": [
    21,
    41,
    56,
    125
  ],
  "txs": [
    {
      "hash": "7d142b878b7894fb916280d0bee0b5c4f8970e1adbc9d1a2e9057a0b8187b709",
      "witnessHash": "2521e8ab766ec523a97c6f0acb48d36b5b0684dc5e1cfd5e3cd703eb2d8386e8",
      "fee": 0,
      "rate": 0,
      "mtime": 1528316209,
      "index": 0,
      "version": 0,
      "inputs": [
        {
          "prevout": {
            "hash": "0000000000000000000000000000000000000000000000000000000000000000",
            "index": 4294967295
          },
          "witness": [
            "6d696e65642062792068736b64",
            "0569cfb705858fae",
            "0000000000000000"
          ],
          "sequence": 368430654,
          "address": null
        }
      ],
      "outputs": [
        {
          "value": 500000000,
          "address": "rs1qpu06wprkwleh579mureghcasjhu9uwge6pltn5",
          "covenant": {
            "type": 0,
            "items": []
          }
        }
      ],
      "locktime": 1,
      "hex": "00000000010000000000000000000000000000000000000000000000000000000000000000ffffffff030d6d696e65642062792068736b64080569cfb705858fae0800000000000000003ecef515010065cd1d0000000000140f1fa7047677f37a78bbe0f28be3b095f85e3919000001000000"
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
tx | transaction hash
