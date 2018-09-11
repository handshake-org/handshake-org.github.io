# hsd - Coins
Getting coin information via API.

*Coin stands for UTXO*

<aside class="info">
You need to enable <code>index-address</code> in order to lookup coins by address.<br>
You can also enable <code>index-tx</code> to lookup transactions by txid.<br>
Launch the hsd daemon with these arguments:<br>
<code>hsd --daemon --index-address=true --index-tx=true</code><br>
These index arguments cannot be changed once hsd has been started for the first time, without resyncing the node.
</aside>


## Get coin by Outpoint

<aside class="info">
This API call is always available regardless indexing options.
</aside>

```javascript
let hash, index;
```

```shell--vars
hash='7d142b878b7894fb916280d0bee0b5c4f8970e1adbc9d1a2e9057a0b8187b709';
index=0;
```

```shell--curl
curl $url/coin/$hash/$index
```

```shell--cli
hsd-cli coin $hash $index
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
  const result = await client.getCoin(hash, index);
  console.log(result);
})();
```

> The above command returns JSON structured like this:

```json
{
  "version": 0,
  "height": 1,
  "value": 500000000,
  "address": "rs1qpu06wprkwleh579mureghcasjhu9uwge6pltn5",
  "covenant": {
    "type": 0,
    "items": []
  },
  "coinbase": false,
  "hash": "7d142b878b7894fb916280d0bee0b5c4f8970e1adbc9d1a2e9057a0b8187b709",
  "index": 0
}
```

Get coin by outpoint (hash and index). Returns coin in hsd coin JSON format.
`value` is always expressed in subunits.

### HTTP Request
`GET /coin/:hash/:index`

### URL Parameters
Parameter | Description
--------- | -----------
:hash     | Hash of tx
:index    | Output's index in tx



## Get coins by address

```javascript
let address;
```

```shell--vars
address='rs1qpu06wprkwleh579mureghcasjhu9uwge6pltn5';
```

```shell--curl
curl $url/coin/address/$address
```

```shell--cli
hsd-cli coin $address
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
  const result = await client.getCoinsByAddress(address);
  console.log(result);
})();
```

> The above command returns JSON structured like this:

```json
[
  {
    "version": 0,
    "height": 1,
    "value": 500000000,
    "address": "rs1qpu06wprkwleh579mureghcasjhu9uwge6pltn5",
    "covenant": {
      "type": 0,
      "items": []
    },
    "coinbase": true,
    "hash": "7d142b878b7894fb916280d0bee0b5c4f8970e1adbc9d1a2e9057a0b8187b709",
    "index": 0
  },
  ...
  ...
  {
    "version": 0,
    "height": 2,
    "value": 500000000,
    "address": "rs1qpu06wprkwleh579mureghcasjhu9uwge6pltn5",
    "covenant": {
      "type": 0,
      "items": []
    },
    "coinbase": true,
    "hash": "b24377e65d11eee09a19163882b3f4715e091fcb07336ae1e1a96ca8854b4326",
    "index": 0
  }
]
```

Get coin objects array by address.

### HTTP Request
`GET /coin/address/:address`

### URL Parameters
Parameter | Description
--------- | -----------
:address  | handshake address



## Get coins by addresses

```javascript
let address0, address1;
```

```shell--vars
address0='rs1qpu06wprkwleh579mureghcasjhu9uwge6pltn5';
address1='rs1qcxuurryemelaj64k6rswn8x9aa8nd9nafa47ag';
```

```shell--curl
curl $url/coin/address \
  -H 'Content-Type: application/json' \
  -X POST \
  --data '{ "addresses":[ "'$address0'", "'$address1'" ]}'
```

```shell--cli
No CLI Option.
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
  const result = await client.getCoinsByAddresses([address0, address1]);
  console.log(result);
})().catch((err) => {
  console.error(err.stack);
});
```

> The above command returns JSON structured like this:

```json
[
  {
    "version": 0,
    "height": 1,
    "value": 500000000,
    "address": "rs1qpu06wprkwleh579mureghcasjhu9uwge6pltn5",
    "covenant": {
      "type": 0,
      "items": []
    },
    "coinbase": true,
    "hash": "7d142b878b7894fb916280d0bee0b5c4f8970e1adbc9d1a2e9057a0b8187b709",
    "index": 0
  },
  {
    "version": 0,
    "height": 2,
    "value": 500000000,
    "address": "rs1qcxuurryemelaj64k6rswn8x9aa8nd9nafa47ag",
    "covenant": {
      "type": 0,
      "items": []
    },
    "coinbase": true,
    "hash": "b24377e65d11eee09a19163882b3f4715e091fcb07336ae1e1a96ca8854b4326",
    "index": 0
  }
]

```

Get coins by addresses, returns array of coin objects.

### HTTP Request
`POST /coin/address`

### POST Parameters (JSON)
Parameter | Description
--------- | -----------
addresses | List of handshake addresses
