# RPC Calls - Mempool

## getmempoolinfo

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getmempoolinfo"
  }'
```

```shell--cli
hsd-cli rpc getmempoolinfo
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
  const result = await client.execute('getmempoolinfo');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "size": 5,
  "bytes": 14120,
  "usage": 14120,
  "maxmempool": 100000000,
  "mempoolminfee": 0.00001
}
```

Returns informations about mempool.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getmempoolancestors

```javascript
let txhash, verbose;
```

```shell--vars
txhash='0e690d6655767c8b388e7403d13dc9ebe49b68e3bd46248c840544f9da87d1e8';
verbose=1;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getmempoolancestors",
    "params": [ "'$txhash'", '$verbose' ]
  }'
```

```shell--cli
hsd-cli rpc getmempoolancestors $txhash $verbose
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
  const result = await client.execute('getmempoolancestors', [ txhash, verbose ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
// verbose=1
[
  {
    "size": 226,
    "fee": 0.0000454,
    "modifiedfee": 0,
    "time": 1527103521,
    "height": 100,
    "startingpriority": 0,
    "currentpriority": 0,
    "descendantcount": 1,
    "descendantsize": 451,
    "descendantfees": 9080,
    "ancestorcount": 2,
    "ancestorsize": 0,
    "ancestorfees": 0,
    "depends": [
      "7922c798ea02c3957393bb7c373ba89e0a337d049564aeb64a9fd2b8d4998795"
    ]
  },
  {
    "size": 225,
    "fee": 0.0000454,
    "modifiedfee": 0,
    "time": 1527103519,
    "height": 100,
    "startingpriority": 0,
    "currentpriority": 0,
    "descendantcount": 2,
    "descendantsize": 676,
    "descendantfees": 13620,
    "ancestorcount": 1,
    "ancestorsize": 0,
    "ancestorfees": 0,
    "depends": [
      "d54e576d30f9014ffb06a31b9e36f2f5bb360e8c54980188ee4b09a979e092c2"
    ]
  },
  ...
]
```

```json
// verbose=0
[
  "56ab7663c80cb6ffc9f8a4b493d77b2e6f52ae8ff64eefa8899c2065922665c8"
]
```

returns all in-mempool ancestors for a transaction in the mempool.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txhash | Required | Transaction Hash
2 | verbose | false | False returns only tx hashs, true - returns dependency tx info



## getmempooldescendants

```javascript
let txhash, verbose;
```

```shell--vars
txhash='7922c798ea02c3957393bb7c373ba89e0a337d049564aeb64a9fd2b8d4998795';
verbose=1;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getmempooldescendants",
    "params": [ "'$txhash'", '$verbose' ]
  }'
```

```shell--cli
hsd-cli rpc getmempooldescendants $txhash $verbose
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
  const result = await client.execute('getmempooldescendants', [ txhash, verbose ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
// verbose=1
[
  {
    "size": 226,
    "fee": 0.0000454,
    "modifiedfee": 0,
    "time": 1527103521,
    "height": 100,
    "startingpriority": 0,
    "currentpriority": 0,
    "descendantcount": 1,
    "descendantsize": 451,
    "descendantfees": 9080,
    "ancestorcount": 2,
    "ancestorsize": 0,
    "ancestorfees": 0,
    "depends": [
      "7922c798ea02c3957393bb7c373ba89e0a337d049564aeb64a9fd2b8d4998795"
    ]
  },
  {
    "size": 225,
    "fee": 0.0000454,
    "modifiedfee": 0,
    "time": 1527103523,
    "height": 100,
    "startingpriority": 0,
    "currentpriority": 0,
    "descendantcount": 0,
    "descendantsize": 225,
    "descendantfees": 4540,
    "ancestorcount": 3,
    "ancestorsize": 0,
    "ancestorfees": 0,
    "depends": [
      "e66c029a755d326f14cc32f485ea43e705ef59ed4a8061e8f47e681fbdefefea"
    ]
  }
]
[e
```

```json
// verbose=0
[
  "939a3b8485b53a718d89e7e4412473b3762fa1d9bbd555fc8b01e73be0ab1881"
]
```

returns all in-mempool descendants for a transaction in the mempool.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txhash | Required | Transaction hash
2 | verbose | false | False returns only tx hashs, true - returns dependency tx info



## getmempoolentry

```javascript
let txhash;
```

```shell--vars
txhash='0e690d6655767c8b388e7403d13dc9ebe49b68e3bd46248c840544f9da87d1e8';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getmempoolentry",
    "params": [ "'$txhash'" ]
  }'
```

```shell--cli
hsd-cli rpc getmempoolentry $txhash
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
  const result = await client.execute('getmempoolentry', [ txhash ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "size": 225,
  "fee": 0.0000454,
  "modifiedfee": 0,
  "time": 1527103523,
  "height": 100,
  "startingpriority": 0,
  "currentpriority": 0,
  "descendantcount": 0,
  "descendantsize": 225,
  "descendantfees": 4540,
  "ancestorcount": 3,
  "ancestorsize": 0,
  "ancestorfees": 0,
  "depends": [
    "e66c029a755d326f14cc32f485ea43e705ef59ed4a8061e8f47e681fbdefefea"
  ]
}
```

returns mempool transaction info by its hash.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txhash | Required | Transaction Hash



## getrawmempool

```javascript
let verbose;
```

```shell--vars
verbose=1;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getrawmempool",
    "params": [ '$verbose' ]
  }'
```

```shell--cli
hsd-cli rpc getrawmempool $verbose
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
  const result = await client.execute('getrawmempool', [ verbose ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "d54e576d30f9014ffb06a31b9e36f2f5bb360e8c54980188ee4b09a979e092c2": {
    "size": 225,
    "fee": 0.0000454,
    "modifiedfee": 0,
    "time": 1527103516,
    "height": 100,
    "startingpriority": 2200000000,
    "currentpriority": 2200000000,
    "descendantcount": 3,
    "descendantsize": 901,
    "descendantfees": 18160,
    "ancestorcount": 0,
    "ancestorsize": 0,
    "ancestorfees": 0,
    "depends": []
  },
  "7922c798ea02c3957393bb7c373ba89e0a337d049564aeb64a9fd2b8d4998795": {
    "size": 225,
    "fee": 0.0000454,
    "modifiedfee": 0,
    "time": 1527103519,
    "height": 100,
    "startingpriority": 0,
    "currentpriority": 0,
    "descendantcount": 2,
    "descendantsize": 676,
    "descendantfees": 13620,
    "ancestorcount": 1,
    "ancestorsize": 0,
    "ancestorfees": 0,
    "depends": [
      "d54e576d30f9014ffb06a31b9e36f2f5bb360e8c54980188ee4b09a979e092c2"
    ]
  },
  ...
}
```

Returns mempool detailed information (on verbose).
Or mempool tx list.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | verbose | false | False returns only tx hashs, true - returns full tx info



## prioritisetransaction

```javascript
let txhash, priorityDelta, feeDelta;
```

```shell--vars
txhash='0e690d6655767c8b388e7403d13dc9ebe49b68e3bd46248c840544f9da87d1e8';
priorityDelta=1000;
feeDelta=1000;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "prioritisetransaction",
    "params": [ "'$txhash'", '$priorityDelta', '$feeDelta' ]
  }'
```

```shell--cli
hsd-cli rpc prioritisetransaction $txhash $priorityDelta $feeDelta
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
  const result = await client.execute('prioritisetransaction', [ txhash, priorityDelta, feeDelta ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
true
```

Prioritises the transaction.

*Note: changing fee or priority will only trick local miner (using this mempool)
into accepting Transaction(s) into the block. (even if Priority/Fee doen't qualify)*


N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txhash | Required | Transaction hash
2 | priority delta | Required | Virtual priority to add/subtract to the entry
3 | fee delta | Required | Virtual fee to add/subtract to the entry



## estimatefee

```javascript
let nblocks;
```

```shell--vars
nblocks=10;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "estimatefee",
    "params": [ '$nblocks' ]
  }'
```

```shell--cli
hsd-cli rpc estimatefee $nblocks
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
  const result = await client.execute('estimatefee', [ nblocks ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
0.001
```

Estimates fee to be paid for transaction.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | nblocks | 1 | Number of blocks to check for estimation.



## estimatepriority

```javascript
let nblocks;
```

```shell--vars
nblocks=10;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "estimatepriority",
    "params": [ '$nblocks' ]
  }'
```

```shell--cli
hsd-cli rpc estimatepriority $nblocks
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
  const result = await client.execute('estimatepriority', [ nblocks ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
718158904.3501
```

estimates the priority (coin age) that a transaction needs in order to be included within a certain number of blocks as a free high-priority transaction.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | nblocks | 1 | Number of blocks to check for estimation.



## estimatesmartfee

```javascript
let nblocks;
```

```shell--vars
nblocks=10;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "estimatesmartfee",
    "params": [ '$nblocks' ]
  }'
```

```shell--cli
hsd-cli rpc estimatesmartfee $nblocks
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
  const result = await client.execute('estimatesmartfee', [ nblocks ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "fee": 0.001,
  "blocks": 10
}
```

Estimates smart fee to be paid for transaction.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | nblocks | 1 | Number of blocks to check for estimation.



## estimatesmartpriority

```javascript
let nblocks;
```

```shell--vars
nblocks=10;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "estimatesmartpriority",
    "params": [ '$nblocks' ]
  }'
```

```shell--cli
hsd-cli rpc estimatesmartpriority $nblocks
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
  const result = await client.execute('estimatesmartpriority', [ nblocks ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "priority": 718158904.3501,
  "blocks": 10
}
```

estimates smart priority (coin age) that a transaction needs in order to be included within a certain number of blocks as a free high-priority transaction.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | nblocks | 1 | Number of blocks to check for estimation.



