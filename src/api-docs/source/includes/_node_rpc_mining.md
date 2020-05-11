# RPC Calls - Mining

*Note: many mining-related RPC calls require `hsd` to be started with the flag `--coinbase-address` designating a comma-separated list of payout addresses, randomly selected during block creation*

## getnetworkhashps

```javascript
let blocks, height;
```

```shell--vars
blocks=120;
height=1000000;
```

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getnetworkhashps",
    "params": [ '$blocks', '$height' ]
  }'
```

```shell--cli
hsd-cli rpc getnetworkhashps $blocks $height
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
  const result = await client.execute('getnetworkhashps', [ blocks, height ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
453742051556.55084
```

Returns the estimated current or historical network hashes per second, based on last `blocks`.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | blocks | 120 | Number of blocks to lookup.
2 | height | 1 | Starting height for calculations.



## getmininginfo

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getmininginfo",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc getmininginfo
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
  const result = await client.execute('getmininginfo', []);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "blocks": 101,
  "currentblocksize": 0,
  "currentblockweight": 0,
  "currentblocktx": 0,
  "difficulty": 0,
  "errors": "",
  "genproclimit": 0,
  "networkhashps": 8.766601909687916e-7,
  "pooledtx": 0,
  "testnet": true,
  "chain": "regtest",
  "generate": false
}

```

Returns mining info.

*Note: currentblocksize, currentblockweight, currentblocktx, difficulty are returned when there's active work.*
*generate - is true when `hsd` itself is mining.*

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getwork

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getwork",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc getwork
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
  const result = await client.execute('getwork');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "network": "regtest",
  "data": "00000000ae127a29c02d7b13ed0a3d57f913392a7f8f82b50295970585cbfad8bc6577b23ce9a239a694cbea6345611ce9683894d2b2a277c8c939a237dc7f9d784880bf1497421d274050a429329682277a21a0e7410137c8ff1b93dff083c6a4885b48f57e593ae36828007cb731af13f68e3c33b39c81a126d921102baccd930ec13b4ff8195b00000000ffff7f200000000000000000000000000000000000000000",
  "target": "7fffff0000000000000000000000000000000000000000000000000000000000",
  "height": 6,
  "time": 1528428623
}
```

Returns hashing work to be solved by miner.
Or submits solved block.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | data | | Data to be submitted to the network.

## getworklp

```shell--curl
# Because there is a request timeout set on CLI http requests.
# without manually adjusting the timeout (or receiving a new transaction on the current
# network) this call will timeout before the request is complete.
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getworklp",
    "params": []
  }'
```

```shell--cli
# Because there is a request timeout set on CLI http requests.
# without manually adjusting the timeout (or receiving a new transaction on the current
# network) this call will timeout before the request is complete.
hsd-cli rpc getworklp
```

```javascript
// Because there is a request timeout set on CLI http requests.
// without manually adjusting the timeout (or receiving a new transaction on the current
// network) this call will timeout before the request is complete.
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
  const result = await client.execute('getworklp');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "network": "regtest",
  "data": "00000000ae127a29c02d7b13ed0a3d57f913392a7f8f82b50295970585cbfad8bc6577b23ce9a239a694cbea6345611ce9683894d2b2a277c8c939a237dc7f9d784880bf1497421d274050a429329682277a21a0e7410137c8ff1b93dff083c6a4885b48f57e593ae36828007cb731af13f68e3c33b39c81a126d921102baccd930ec13b4ff8195b00000000ffff7f200000000000000000000000000000000000000000",
  "target": "7fffff0000000000000000000000000000000000000000000000000000000000",
  "height": 6,
  "time": 1528428623
}
```

Long polling for new work.

Returns new work, whenever new TX is received in the mempool or
new block has been discovered. So miner can restart mining on new data.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getblocktemplate

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getblocktemplate",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc getblocktemplate
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
  const result = await client.execute('getblocktemplate');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "capabilities": [
    "proposal"
  ],
  "mutable": [
    "time",
    "transactions",
    "prevblock"
  ],
  "version": 0,
  "rules": [],
  "vbavailable": {},
  "vbrequired": 0,
  "height": 111,
  "previousblockhash": "6817423dbb46da50ef7bde47c6dab28e53cbe91f06ecf68e8da0c5283d08e1fe",
  "treeroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "reservedroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "mask": "0000fd0ab9566be24f5d76763172b89c513361d67016a03e57baac69155f2eda",
  "target": "7fffff0000000000000000000000000000000000000000000000000000000000",
  "bits": "207fffff",
  "noncerange": "000000000000000000000000000000000000000000000000ffffffffffffffffffffffffffffffffffffffffffffffff",
  "curtime": 1581347561,
  "mintime": 1581346914,
  "maxtime": 1581354761,
  "expires": 1581354761,
  "sigoplimit": 80000,
  "sizelimit": 1000000,
  "weightlimit": 4000000,
  "longpollid": "6817423dbb46da50ef7bde47c6dab28e53cbe91f06ecf68e8da0c5283d08e1fe00000001",
  "submitold": false,
  "coinbaseaux": {
    "flags": "6d696e656420627920687364"
  },
  "coinbasevalue": 2000003040,
  "claims": [],
  "airdrops": [],
  "transactions": [
    {
      "data": "000000000103858fc9d1c73d5250f2526ef71e17cb37d542d0fd7c8ddd061ab5f42ac47c5900000000ffffffff0250690f000000000000206237ceaffc6f2960a97c82e5a0b1e40455ee34010b1dd9c3481877a0883459760000d01e267700000000001464ae86dbe6f80c1d50daf5eafade990a5e1bcbdb0000000000000241813478628bcca531d716e088a7efef90eb8155d1afa87156dd6996e12b68e1776121cfbb022de662ce32e2b4c005fbcb033dc4cd06bbd7b99ff64f2af7cb29fc0121021ecadaa8a5146e04aad0d05e7116eeb961f1457b3094b7030f362e31552c2ed0",
      "txid": "d1a4c16e5771115c3f251c0e13a912871af70ffde5cef8b5d5e3357806c80f24",
      "hash": "550f276f2acbb5c7c84e62b591ff9f13cd7c06a36bcf1c42a2b53105bfc4c9e9",
      "depends": [],
      "fee": 3040,
      "sigops": 0,
      "weight": 605
    }
  ]
}
```

returns block template or proposal for use with mining.
Also validates proposal if `mode` is specified as `proposal`.

*Note: This is described in
[BIP22 - Fundamentals](https://github.com/bitcoin/bips/blob/master/bip-0022.mediawiki),
[BIP23 - Pooled Mining](https://github.com/bitcoin/bips/blob/master/bip-0023.mediawiki),
[BIP145 - Updates for Segregated Witness](https://github.com/bitcoin/bips/blob/master/bip-0145.mediawiki)*

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1  | jsonrequestobject | {} | JSONRequestObject.



## submitblock

```javascript
let blockdata;
```

```shell--vars
blockdata='000000203f6397a1442eb6a9901998c4a4b432f8573c7a490b2d5e6d6f2ad0d0fca25e2c56940d79c8f81f3eb5e998bcf79dbf8c7d3b13b01adaac526cf9df8ee385ec0c1ac0055bffff7f20000000000101000000010000000000000000000000000000000000000000000000000000000000000000ffffffff1f01640e6d696e65642062792062636f696e046c62c046080000000000000000ffffffff0100f2052a010000001976a91473815900ee35f3815b3407af2eeb1b611cf533d788ac00000000';
```

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "submitblock",
    "params": [ "'$blockdata'" ]
  }'
```

```shell--cli
hsd-cli rpc submitblock $blockdata
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
  const result = await client.execute('submitblock', [ blockdata ]);
  console.log(result);
})();
```

Adds block to chain.


### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1  | blockdata | Required. | Mined block data (hex)

## verifyblock

```javascript
let blockdata;
```

```shell--vars
blockdata='000000203f6397a1442eb6a9901998c4a4b432f8573c7a490b2d5e6d6f2ad0d0fca25e2c56940d79c8f81f3eb5e998bcf79dbf8c7d3b13b01adaac526cf9df8ee385ec0c1ac0055bffff7f20000000000101000000010000000000000000000000000000000000000000000000000000000000000000ffffffff1f01640e6d696e65642062792062636f696e046c62c046080000000000000000ffffffff0100f2052a010000001976a91473815900ee35f3815b3407af2eeb1b611cf533d788ac00000000';
```

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "verifyblock",
    "params": [ "'$blockdata'" ]
  }'
```

```shell--cli
hsd-cli rpc verifyblock $blockdata
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
  // Block data is old, so it should return error
  const result = await client.execute('verifyblock', [ blockdata ]);
  console.log(result);
})();
```

Verifies the block data.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1  | blockdata | Required. | Mined block data (hex)





## setgenerate

```javascript
let mining, proclimit;
```

```shell--vars
mining=1;
proclimit=1;
```

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "setgenerate",
    "params": [ '$mining', '$proclimit' ]
  }'
```

```shell--cli
hsd-cli rpc setgenerate $mining $proclimit
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
  const result = await client.execute('setgenerate', [ mining, proclimit ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
true
```

Will start the mining on CPU.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1  | mining | 0 | `true` will start mining, `false` will stop.
2 | proclimit | 0 |



## getgenerate

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getgenerate",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc getgenerate
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
  const result = await client.execute('getgenerate');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
true
```

Returns status of mining on Node.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None.



## generate

```javascript
let numblocks;
```

```shell--vars
numblocks=2;
```

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "generate",
    "params": [ '$numblocks' ]
  }'
```

```shell--cli
hsd-cli rpc generate $numblocks
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
  // Timeout error
  const result = await client.execute('generate', [ numblocks ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  "11c5504f63aebe71b3e6f46a31f83dd24e65e392a11e905f6acdb7346c8b18c0",
  "64455db5aa23d6277027aea1851d85da8ee07958ed7caee2ca630b065f4faaa8"
]
```

Mines `numblocks` number of blocks. Will return once all blocks are mined. CLI command may
timeout before that happens.


### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | numblocks | 1 | Number of blocks to mine.
2 | maxtries |



## generatetoaddress

```javascript
let numblocks, address;
```

```shell--vars
numblocks=2;
address='RTZJdYScA7uGb5pbQPEczpDmq9HiYLv2fJ';
```

```shell--curl
# Will return once all blocks are mined.
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "generatetoaddress",
    "params": [ '$numblocks', "'$address'" ]
  }'
```

```shell--cli
# Timeout error
hsd-cli rpc generatetoaddress $numblocks $address
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
  // Timeout error
  const result = await client.execute('generatetoaddress', [ numblocks, address ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  "65e54939c20f61e54173596eb72a7b00b96baac0c58d2cb30d1fad64d1b51dbb",
  "3959ee3f58bb1ac05af9bebb51ebf7872bcd4231fa41c384bcfef468541b5166"
]
```
Mines `numblocks` blocks, with `address` as coinbase.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | numblocks | 1 | Number of blocks to mine.
2 | address | | Coinbase address for new blocks.
