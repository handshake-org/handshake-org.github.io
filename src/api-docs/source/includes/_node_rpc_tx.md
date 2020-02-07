# RPC Calls - Transactions

## gettxout

```javascript
let txhash, index, includemempool;
```

```shell--vars
txhash='b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3';
index=0;
includemempool=1;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "gettxout",
    "params": [ "'$txhash'", '$index', '$includemempool' ]
  }'
```

```shell--cli
hsd-cli rpc gettxout $txhash $index $includemempool
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
  const result = await client.execute('gettxout', [ txhash, index, includemempool ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "bestblock": "be818dc2e986f872118e2c4d2995d14beb03edada40a448d24daf7b62cc272cf",
  "confirmations": 3,
  "value": 500,
  "address": {
    "version": 0,
    "hash": "f039bea7884a3e8568ed967ee1f830afd5cba990"
  },
  "version": 0,
  "coinbase": true
}
```

Get outpoint of the transaction.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txid | Required | Transaction hash
2 | index | Required | Index of the Outpoint tx.
3 | includemempool | true | Whether to include mempool transactions.



## gettxoutsetinfo

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "gettxoutsetinfo",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc gettxoutsetinfo
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
  const result = await client.execute('gettxoutsetinfo');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "height": 100,
  "bestblock": "0e11d85b2081b84e131ba6692371737e6bb2aa7bc6d16e92954ffb1f9ad762e5",
  "transactions": 101,
  "txouts": 100,
  "bytes_serialized": 0,
  "hash_serialized": 0,
  "total_amount": 5000
}
```

Returns information about UTXO's from Chain.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getrawtransaction

```javascript
let txhash, verbose;
```

```shell--vars
txhash='b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3';
verbose=0;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "getrawtransaction",
    "params": [ "'$txhash'", '$verbose' ]
  }'
```

```shell--cli
hsd-cli rpc getrawtransaction $txhash $verbose
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
  const result = await client.execute('getrawtransaction', [ txhash, verbose ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
"00000000010000000000000000000000000000000000000000000000000000000000000000ffffffff030d6d696e65642062792068736b64088d8679b7393cc0ac0800000000000000000bf6305f010065cd1d000000000014f039bea7884a3e8568ed967ee1f830afd5cba990000001000000"
```

Returns raw transaction

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txhash | Required | Transaction hash
2 | verbose | false | Returns json formatted if true



## decoderawtransaction

```javascript
let rawtx;
```

```shell--vars
rawtx='00000000010000000000000000000000000000000000000000000000000000000000000000ffffffff030d6d696e65642062792068736b64088d8679b7393cc0ac0800000000000000000bf6305f010065cd1d000000000014f039bea7884a3e8568ed967ee1f830afd5cba990000001000000';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "decoderawtransaction",
    "params": [ "'$rawtx'" ]
  }'
```

```shell--cli
hsd-cli rpc decoderawtransaction $rawtx
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
  const result = await client.execute('decoderawtransaction', [ rawtx ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "txid": "b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3",
  "hash": "6a46ce951a4239596405d8bcc3a12a20a43978f57e8cb2ef0cf29611d8a25d51",
  "size": 115,
  "vsize": 91,
  "version": 0,
  "locktime": 1,
  "vin": [
    {
      "coinbase": true,
      "txid": "0000000000000000000000000000000000000000000000000000000000000000",
      "vout": 4294967295,
      "txinwitness": [
        "6d696e65642062792068736b64",
        "8d8679b7393cc0ac",
        "0000000000000000"
      ],
      "sequence": 1597044235
    }
  ],
  "vout": [
    {
      "value": 500,
      "n": 0,
      "address": {
        "version": 0,
        "hash": "f039bea7884a3e8568ed967ee1f830afd5cba990"
      },
      "covenant": {
        "type": 0,
        "items": []
      }
    }
  ],
  "blockhash": null,
  "confirmations": 0,
  "time": 0,
  "blocktime": 0
}
```

Decodes raw tx and provide chain info.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | rawtx | Required | Raw transaction hex



## decodescript

```javascript
let script;
```

```shell--vars
script='76c014af92ad98c7f77559f96430dfef2a6805b87b24f888ac';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "decodescript",
    "params": [ "'$script'" ]
  }'
```

```shell--cli
hsd-cli rpc decodescript $script
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
  const result = await client.execute('decodescript', [ script ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "asm": "OP_DUP OP_BLAKE160 af92ad98c7f77559f96430dfef2a6805b87b24f8 OP_EQUALVERIFY OP_CHECKSIG",
  "type": "PUBKEYHASH",
  "reqSigs": 1,
  "p2sh": "rs1qvgmuatludu5kp2tustj6pv0yq327udqppvwans6grpm6pzp5t9mqwn05ud"
}
```

Decodes script

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | script | Required | Script hex


## sendrawtransaction

```javascript
let rawtx;
```

```shell--vars
rawtx='0100000001eaefefbd1f687ef4e861804aed59ef05e743ea85f432cc146f325d759a026ce6010000006a4730440220718954e28983c875858b5a0094df4607ce2e7c6e9ffea47f3876792b01755c1202205e2adc7c32ff64aaef6d26045f96181e8741e560b6f3a8ef2f4ffd2892add656012103142355370728640592109c3d2bf5592020a6b9226303c8bc98ab2ebcadf057abffffffff02005a6202000000001976a914fe7e0711287688b33b9a5c239336c4700db34e6388ac10ca0f24010000001976a914af92ad98c7f77559f96430dfef2a6805b87b24f888ac00000000';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "sendrawtransaction",
    "params": [ "'$rawtx'" ]
  }'
```

```shell--cli
hsd-cli rpc sendrawtransaction $rawtx
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
  const result = await client.execute('sendrawtransaction', [ rawtx ]);
  console.log(result);
})();
```

>

```json
"0e690d6655767c8b388e7403d13dc9ebe49b68e3bd46248c840544f9da87d1e8"
```

Sends raw transaction without verification

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | rawtx | Required | Raw transaction hex



## createrawtransaction

```javascript
let txhash, txindex, amount, address, data;
```

```shell--vars
txhash='b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3';
txindex=0;
amount=1;
address='rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap';
data='deadbeef';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "createrawtransaction",
    "params": [
      [{ "txid": "'$txhash'", "vout": '$txindex' }],
      { "'$address'": '$amount', "data": "'$data'" }
    ]
  }'
```

```shell--cli
hsd-cli rpc createrawtransaction \
  '[{ "txid": "'$txhash'", "vout": '$txindex' }]' \
  '{ "'$address'": '$amount', "data": "'$data'" }'
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
  const sendTo = {
    data: data
  };
  sendTo[address] = amount;
  const result = await client.execute('createrawtransaction', [ [{ txid: txhash, vout: txindex }], sendTo]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
"0000000001b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb300000000ffffffff0240420f00000000000014f0d9374a2ce80c377187f4bc6c68993c561cb136000000000000000000001f04deadbeef00000000000000"
```

<aside class="info">
Note: Transaction in example doesn't specify change output,
you can do it by specifying another <code>address: amount</code> pair.
</aside>

<aside class="warning">
Amounts are expressed in FULL HNS (not subunits) in all three interface methods.
</aside>

Creates raw, unsigned transaction without any formal verification.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | outpoints | Required | Outpoint list
1.1 | txid | | Transaction Hash
1.2 | vout | | Transaction Outpoint Index
1.3 | sequence | | Sequence number for input
2 | sendto | Required | Map of addresses we are sending to with amounts as values.
2.1 | address | 0 | `address: amount` key pairs (_string_: _float_)
3 | locktime | | earliest time a transaction can be added


## signrawtransaction

```javascript
let rawtx, txhash, txindex, scriptPubKey, amount, privkey;
```

```shell--vars
rawtx='0000000001b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb300000000ffffffff0240420f00000000000014f0d9374a2ce80c377187f4bc6c68993c561cb136000000000000000000001f04deadbeef00000000000000';
txhash='b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb3';
txindex=0;
address='rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc';
amount=1;
privkey='ENced8VD7YWkzPC8FTJ3gTTq4pQhF2PF79QS51mgZq7BgCfiEP5A';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "signrawtransaction",
    "params": [
      "'$rawtx'",
      [{
        "txid": "'$txhash'",
        "vout": '$txindex',
        "address": "'$address'",
        "amount": '$amount'
      }],
      [ "'$privkey'" ]
    ]
  }'
```

```shell--cli
hsd-cli rpc signrawtransaction $rawtx \
  '[{ "txid": "'$txhash'", "vout": '$txindex', "address": "'$address'", "amount": '$amount' }]' \
  '[ "'$privkey'" ]'
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
  const result = await client.execute('signrawtransaction', [ rawtx,
    [{
      txid: txhash,
      vout: txindex,
      address: address,
      amount: amount
    }],
    [ privkey ]
  ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "hex": "0000000001b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb300000000ffffffff0240420f00000000000014f0d9374a2ce80c377187f4bc6c68993c561cb136000000000000000000001f04deadbeef0000000000000241b04faee027f8d4f2b5b3f30446624d46aee82406df161095118e2f587a117d2146ab4fbd90734ab1a339f4813e62cf1723993cbad5bcdfe9d1beda453fc822d9012102deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9",
  "complete": true
}
```

Signs raw transaction

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | rawtx | Required | raw tx
2 | inputs | Required | Coins you're going to spend
2.1 | txid | | Transaction Hash
2.2 | vout | | Transaction Outpoint Index
2.3 | address | | Address which received the output you're going to sign
2.4 | amount | | Amount the output is worth
3 | privkeylist | | List of private keys
4 | sighashtype | | Type of signature hash



## gettxoutproof

```javascript
let txid0, txid1;
```

```shell--vars
txid0='0e690d6655767c8b388e7403d13dc9ebe49b68e3bd46248c840544f9da87d1e8';
txid1='e66c029a755d326f14cc32f485ea43e705ef59ed4a8061e8f47e681fbdefefea';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "gettxoutproof",
    "params": [ ["'$txid0'", "'$txid1'"] ]
  }'
```

```shell--cli
hsd-cli rpc gettxoutproof '[ "'$txid0'", "'$txid1'" ]'
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
  const result = await client.execute('gettxoutproof', [ [ txid0, txid1 ] ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
"00000020e562d79a1ffb4f95926ed1c67baab26b7e73712369a61b134eb881205bd8110ef08c63626ea13ca11fddad4f2c0a2b67354efdcd50f769b73330af205dcdd054cbd3055bffff7f20010000000500000004ae4be9cd199b09f605119820680eb23462746e98fbc2b0c635643f00b34c3cd8958799d4b8d29f4ab6ae6495047d330a9ea83b377cbb937395c302ea98c72279eaefefbd1f687ef4e861804aed59ef05e743ea85f432cc146f325d759a026ce6e8d187daf94405848c2446bde3689be4ebc93dd103748e388b7c7655660d690e02eb01"
```

Checks if transactions are within block.
Returns proof of transaction inclusion (raw MerkleBlock).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txidlist | Required | array of transaction hashes
2 | blockhash | Based on TX | Block hash


## verifytxoutproof

```javascript
let proof;
```

```shell--vars
proof='00000020e562d79a1ffb4f95926ed1c67baab26b7e73712369a61b134eb881205bd8110ef08c63626ea13ca11fddad4f2c0a2b67354efdcd50f769b73330af205dcdd054cbd3055bffff7f20010000000500000004ae4be9cd199b09f605119820680eb23462746e98fbc2b0c635643f00b34c3cd8958799d4b8d29f4ab6ae6495047d330a9ea83b377cbb937395c302ea98c72279eaefefbd1f687ef4e861804aed59ef05e743ea85f432cc146f325d759a026ce6e8d187daf94405848c2446bde3689be4ebc93dd103748e388b7c7655660d690e02eb01';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "verifytxoutproof",
    "params": [ "'$proof'" ]
  }'
```

```shell--cli
hsd-cli rpc verifytxoutproof $proof
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
  const result = await client.execute('verifytxoutproof', [ proof ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  "e66c029a755d326f14cc32f485ea43e705ef59ed4a8061e8f47e681fbdefefea",
  "0e690d6655767c8b388e7403d13dc9ebe49b68e3bd46248c840544f9da87d1e8"
]
```

Checks the proof for transaction inclusion. Returns transaction hash if valid.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | proof | Required | Proof of transaction inclusion (raw MerkleBlock).
