# RPC Calls - Chain

## pruneblockchain

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "pruneblockchain",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc pruneblockchain
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
  const result = await client.execute('pruneblockchain');
  console.log(result);
})();
```

Prunes the blockchain, it will keep blocks specified in Network Configurations.

### Default Prune Options
Network | keepBlocks | pruneAfter
------- | -------    | -------
main    | 288        | 1000
testnet | 10000      | 1000
regtest | 10000      | 1000

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## invalidateblock

```javascript
let blockhash;
```

```shell--vars
blockhash='52d7beaf4c7f392bef2744167c7f4db4bb4113b2635496edcf2d1c94128696aa';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "invalidateblock",
    "params": [ "'$blockhash'" ]
  }'
```

```shell--cli
hsd-cli rpc invalidateblock $blockhash
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
  const result = await client.execute('invalidateblock', [ blockhash ]);
  console.log(result);
})();
```


Invalidates the block in the chain.
It will rewind network to blockhash and invalidate it.

It won't accept that block as valid.
*Invalidation will work while running, restarting node will remove invalid block from list.*

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | blockhash | Required | Block's hash



## reconsiderblock

```javascript
let blockhash;
```

```shell--vars
blockhash='1896e628f8011b77ea80f4582c29c21b3376183683f587ee863050376add3891'
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "reconsiderblock",
    "params": [ "'$blockhash'" ]
  }'
```

```shell--cli
hsd-cli rpc reconsiderblock $blockhash
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
  const result = await client.execute('reconsiderblock', [ blockhash ]);
  console.log(result);
})().catch((err) => {
  console.error(err.stack);
});
```

This rpc command will remove block from invalid block set.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | blockhash | Required | Block's hash
