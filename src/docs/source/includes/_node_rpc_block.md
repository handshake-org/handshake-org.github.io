# RPC Calls - Block

## getblockchaininfo

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "getblockchaininfo" }'
```

```shell--cli
hsk-cli rpc getblockchaininfo
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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
  "blocks": 3,
  "headers": 3,
  "bestblockhash": "be818dc2e986f872118e2c4d2995d14beb03edada40a448d24daf7b62cc272cf",
  "difficulty": 4.6565423739069247e-10,
  "mediantime": 1528329686,
  "verificationprogress": 0.9939113782090621,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000008",
  "pruned": false,
  "softforks": {
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
hsk-cli rpc getbestblockhash
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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
hsk-cli rpc getblockcount
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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
blockhash='c90f06860f712acf8ff1a79b5697644263470a9a7fd91273e34cb121c7a2b4cd';
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
hsk-cli rpc getblock $blockhash $verbose $details
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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
  "hash": "c90f06860f712acf8ff1a79b5697644263470a9a7fd91273e34cb121c7a2b4cd",
  "confirmations": 3,
  "strippedsize": 264,
  "size": 297,
  "weight": 1089,
  "height": 1,
  "version": 0,
  "versionHex": "00000000",
  "merkleroot": "b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3",
  "witnessroot": "6a46ce951a4239596405d8bcc3a12a20a43978f57e8cb2ef0cf29611d8a25d51",
  "treeroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "solution": [
    5,
    22,
    64,
    112
  ],
  "coinbase": [
    "6d696e65642062792068736b64",
    "8d8679b7393cc0ac",
    "0000000000000000"
  ],
  "tx": [
    "b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3"
  ],
  "time": 1528329568,
  "mediantime": 1528329568,
  "bits": 545259519,
  "difficulty": 4.6565423739069247e-10,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000004",
  "previousblockhash": "695e315d274ec2de4d050ef63d497a2cbaf8103bbed0c559d5ac45d840015be5",
  "nextblockhash": "11f9987bd778436df43e287582c5c76e1d3689dd28a8d5f3cf097124abdbf61f"
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
blockheight=1;
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
hsk-cli rpc getblockbyheight $blockheight $verbose $details
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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
  "hash": "c90f06860f712acf8ff1a79b5697644263470a9a7fd91273e34cb121c7a2b4cd",
  "confirmations": 3,
  "strippedsize": 264,
  "size": 297,
  "weight": 1089,
  "height": 1,
  "version": 0,
  "versionHex": "00000000",
  "merkleroot": "b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3",
  "witnessroot": "6a46ce951a4239596405d8bcc3a12a20a43978f57e8cb2ef0cf29611d8a25d51",
  "treeroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "solution": [
    5,
    22,
    64,
    112
  ],
  "coinbase": [
    "6d696e65642062792068736b64",
    "8d8679b7393cc0ac",
    "0000000000000000"
  ],
  "tx": [
    "b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3"
  ],
  "time": 1528329568,
  "mediantime": 1528329568,
  "bits": 545259519,
  "difficulty": 4.6565423739069247e-10,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000004",
  "previousblockhash": "695e315d274ec2de4d050ef63d497a2cbaf8103bbed0c559d5ac45d840015be5",
  "nextblockhash": "11f9987bd778436df43e287582c5c76e1d3689dd28a8d5f3cf097124abdbf61f"
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
hsk-cli rpc getblockhash $blockheight
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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
blockhash='c90f06860f712acf8ff1a79b5697644263470a9a7fd91273e34cb121c7a2b4cd';
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
hsk-cli rpc getblockheader $blockhash $verbose
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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
  "hash": "c90f06860f712acf8ff1a79b5697644263470a9a7fd91273e34cb121c7a2b4cd",
  "confirmations": 3,
  "height": 1,
  "version": 0,
  "versionHex": "00000000",
  "merkleroot": "b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3",
  "witnessroot": "6a46ce951a4239596405d8bcc3a12a20a43978f57e8cb2ef0cf29611d8a25d51",
  "treeroot": "0000000000000000000000000000000000000000000000000000000000000000",
  "solution": [
    5,
    22,
    64,
    112
  ],
  "time": 1528329568,
  "mediantime": 1528329568,
  "bits": 545259519,
  "difficulty": 4.6565423739069247e-10,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000004",
  "previousblockhash": "695e315d274ec2de4d050ef63d497a2cbaf8103bbed0c559d5ac45d840015be5",
  "nextblockhash": "11f9987bd778436df43e287582c5c76e1d3689dd28a8d5f3cf097124abdbf61f"
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
hsk-cli rpc getchaintips
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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
hsk-cli rpc getdifficulty
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
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

