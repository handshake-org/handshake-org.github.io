# RPC Calls - Block

## getblockchaininfo

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "getblockchaininfo" }'
```

```shell--cli
hsd-cli rpc getblockchaininfo
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
  const result = await client.execute('getblockchaininfo');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "chain": "regtest",
  "blocks": 101,
  "headers": 101,
  "bestblockhash": "76fb75dcb6d27b167dac8c01ad9e4fc68490bd9c3515cda02a20db412bf23930",
  "treeRoot": "0000000000000000000000000000000000000000000000000000000000000000",
  "difficulty": 4.6565423739069247e-10,
  "mediantime": 1581299452,
  "verificationprogress": 1,
  "chainwork": "00000000000000000000000000000000000000000000000000000000000000cc",
  "pruned": false,
  "softforks": {
    "hardening": {
      "status": "defined",
      "bit": 0,
      "startTime": 1581638400,
      "timeout": 1707868800
    },
    "testdummy": {
      "status": "defined",
      "bit": 28,
      "startTime": 0,
      "timeout": 4294967295
    }
  },
  "pruneheight": null
}
```

Returns blockchain information.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getbestblockhash

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "getbestblockhash" }'
```

```shell--cli
hsd-cli rpc getbestblockhash
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
  const result = await client.execute('getbestblockhash');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
"498d003ecfc60ee829cdc3640dc305583057d88e2c38a7d57dbe0f92aa2bb512"
```

Returns Block Hash of the tip.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getblockcount


```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "getblockcount" }'
```

```shell--cli
hsd-cli rpc getblockcount
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
  const result = await client.execute('getblockcount');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
98
```

Returns block count.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. ||||



## getblock

```javascript
let blockhash, details, verbose;
```

```shell--vars
blockhash='76fb75dcb6d27b167dac8c01ad9e4fc68490bd9c3515cda02a20db412bf23930';
verbose=1;
details=0;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getblock",
    "params": [ "'$blockhash'", '$verbose', '$details' ]
  }'
```

```shell--cli
hsd-cli rpc getblock $blockhash $verbose $details
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
  const result = await client.execute('getblock', [ blockhash, verbose, details ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "hash": "76fb75dcb6d27b167dac8c01ad9e4fc68490bd9c3515cda02a20db412bf23930",
  "confirmations": 1,
  "strippedsize": 319,
  "size": 351,
  "weight": 1308,
  "height": 101,
  "version": 0,
  "versionHex": "00000000",
  "merkleroot": "67f0c36f0a12f276cdd0feb26dacf1bb93df31b9df68c4be09c7ac8231e76794",
  "witnessroot": "c8a4848c5d4b3b669ff5642ecfc5ab146d928d174c8d708d252a635819b4ccce",
  "treeroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "reservedroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "mask": "0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase": [
    "6d696e656420627920687364",
    "efc784672034e0ec",
    "0000000000000000"
  ],
  "tx": [
    "d43a1192315124dcddf3b59902dd6bfef9cf6bcfbb07377e1b69ab1919f99d4e"
  ],
  "time": 1581299453,
  "mediantime": 1581299452,
  "bits": 545259519,
  "difficulty": 4.6565423739069247e-10,
  "chainwork": "00000000000000000000000000000000000000000000000000000000000000cc",
  "previousblockhash": "21ff4a8264d4b23db3b6a0d870e16d5e49c2b1f8c87b9b79ea342808a2914ed0",
  "nextblockhash": null
}
```

Returns information about block.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | blockhash | Required | Hash of the block
2 | verbose | true | If set to false, it will return hex of the block
3 | details | false | If set to true, it will return transaction details too.



## getblockbyheight

```javascript
let blockhash, details, verbose;
```

```shell--vars
blockheight=101;
verbose=1;
details=0;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getblockbyheight",
    "params": [ '$blockheight', '$verbose', '$details' ]
  }'
```

```shell--cli
hsd-cli rpc getblockbyheight $blockheight $verbose $details
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
  const result = await client.execute('getblockbyheight', [ blockheight, verbose, details ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "hash": "5ff00e4394407ee68deaeebe9034be2ba3c4f1a74e66363200ee3f7bba0bd494",
  "confirmations": 10,
  "strippedsize": 319,
  "size": 351,
  "weight": 1308,
  "height": 101,
  "version": 0,
  "versionHex": "00000000",
  "merkleroot": "6b26e5e0c450fc7ab1565e376af0c728c34d1350ea2a940a7d717e893f697816",
  "witnessroot": "bc95c2a01f5857cb90444516f4581b010e84e9c99b36d33cd7d00e245bcfb401",
  "treeroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "reservedroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "mask": "0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase": [
    "6d696e656420627920687364",
    "7a801f3eacdfec0c",
    "0000000000000000"
  ],
  "tx": [
    "eb63b57dec72917ed747fa14901bb7f07689138afa98a7c9a5aef754c5a143c2"
  ],
  "time": 1581346912,
  "mediantime": 1581346912,
  "bits": 545259519,
  "difficulty": 4.6565423739069247e-10,
  "chainwork": "00000000000000000000000000000000000000000000000000000000000000cc",
  "previousblockhash": "233e475602c7c0c002237e0a8ea6d02346216bc06b2447bfe80b38c756ef1eba",
  "nextblockhash": "75cdf5d53071d5629f12dac01d2f312ec04b17f46c085b57bb87df604748817a"
}
```

Returns information about block by height.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | blockheight | Required | height of the block in the blockchain.
2 | verbose | true | If set to false, it will return hex of the block.
3 | details | false | If set to true, it will return transaction details too.



## getblockhash

```javascript
let blockheight;
```

```shell--vars
blockheight=50;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getblockhash",
    "params": [ '$blockheight' ]
  }'
```

```shell--cli
hsd-cli rpc getblockhash $blockheight
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
  const result = await client.execute('getblockhash', [ blockheight ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
"51726259de9560e1924f3cb554ad16e889b6170eb4d01d01f5a4ca8a81d1e318"
```

Returns block's hash given its height.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | blockheight | Required | height of the block in the blockchain.



## getblockheader

```javascript
let blockhash, verbose;
```

```shell--vars
blockhash='5ff00e4394407ee68deaeebe9034be2ba3c4f1a74e66363200ee3f7bba0bd494';
verbose=1;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getblockheader",
    "params": [ "'$blockhash'", '$details' ]
  }'
```

```shell--cli
hsd-cli rpc getblockheader $blockhash $verbose
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
  const result = await client.execute('getblockheader', [ blockhash, verbose ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "hash": "5ff00e4394407ee68deaeebe9034be2ba3c4f1a74e66363200ee3f7bba0bd494",
  "confirmations": 10,
  "height": 101,
  "version": 0,
  "versionHex": "00000000",
  "merkleroot": "6b26e5e0c450fc7ab1565e376af0c728c34d1350ea2a940a7d717e893f697816",
  "witnessroot": "bc95c2a01f5857cb90444516f4581b010e84e9c99b36d33cd7d00e245bcfb401",
  "treeroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "reservedroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "mask": "0000000000000000000000000000000000000000000000000000000000000000",
  "time": 1581346912,
  "mediantime": 1581346912,
  "bits": 545259519,
  "difficulty": 4.6565423739069247e-10,
  "chainwork": "00000000000000000000000000000000000000000000000000000000000000cc",
  "previousblockhash": "233e475602c7c0c002237e0a8ea6d02346216bc06b2447bfe80b38c756ef1eba",
  "nextblockhash": "75cdf5d53071d5629f12dac01d2f312ec04b17f46c085b57bb87df604748817a"
}
```

Returns a block's header given its hash.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | blockheight | Required | height of the block in the blockchain.
2 | verbose | true | If set to false, it will return hex of the block.



## getchaintips

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getchaintips"
  }'
```

```shell--cli
hsd-cli rpc getchaintips
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
  const result = await client.execute('getchaintips');
  console.log(result);
})();
```

Returns chaintips.

> The above command returns JSON "result" like this:

```json
[
  {
    "height": 3,
    "hash": "be818dc2e986f872118e2c4d2995d14beb03edada40a448d24daf7b62cc272cf",
    "branchlen": 0,
    "status": "active"
  },
  ...
]
```

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getdifficulty

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getdifficulty"
  }'
```

```shell--cli
hsd-cli rpc getdifficulty
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
  const result = await client.execute('getdifficulty');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
1048576
```

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |

