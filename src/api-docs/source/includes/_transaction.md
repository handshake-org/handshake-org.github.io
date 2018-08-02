# hsd - Transactions
Getting transaction information via API.

<aside class="info">
You need to enable <code>index-address</code> in order to lookup coins by address.<br>
You can also enable <code>index-tx</code> to lookup transactions by txid.<br>
Launch the hsd daemon with these arguments:<br>
<code>hsd --daemon --index-address=true --index-tx=true</code>
</aside>

## Get tx by txhash

```javascript
let txhash;
```

```shell--vars
txhash='4674eb87021d9e07ff68cfaaaddfb010d799246b8f89941c58b8673386ce294f';
```

```shell--curl
curl $url/tx/$txhash
```

```shell--cli
hsd-cli tx $txhash
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.getTX(txhash);
  console.log(result);
})().catch((err) => {
  console.error(err.stack);
});
```

> The above command returns JSON structured like this:

```json
{
  "hash": "4674eb87021d9e07ff68cfaaaddfb010d799246b8f89941c58b8673386ce294f",
  "witnessHash": "337189c003cf9c2ea413b5b6041c5b9e62f5fdfafcdd6cb54d5829c6cd59dd77",
  "fee": 2800,
  "rate": 20000,
  "mtime": 1528329716,
  "height": -1,
  "block": null,
  "time": 0,
  "index": -1,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "2277cbd9dd1c2552f9998e6861c7fd6866b9a48fa94ec85f03697390e8fa5d4b",
        "index": 0
      },
      "witness": [
        "ef5ae8c401a69123b69da2922514ff62a76a040abb615e79453ad8172a31916c65c82ecebf15d40678b3c749411908e9aaeed1785b23789c746e5f17d11bb4c801",
        "02deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9"
      ],
      "sequence": 4294967295,
      "coin": {
        "version": 0,
        "height": 2,
        "value": 500000000,
        "address": "rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc",
        "covenant": {
          "type": 0,
          "items": []
        },
        "coinbase": true
      }
    }
  ],
  "outputs": [
    {
      "value": 100000000,
      "address": "rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap",
      "covenant": {
        "type": 0,
        "items": []
      }
    },
    {
      "value": 399997200,
      "address": "rs1qx38r5mjzlxfus9yx7nhx3mrg00sv75xc5mksk5",
      "covenant": {
        "type": 0,
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "00000000012277cbd9dd1c2552f9998e6861c7fd6866b9a48fa94ec85f03697390e8fa5d4b000000000241ef5ae8c401a69123b69da2922514ff62a76a040abb615e79453ad8172a31916c65c82ecebf15d40678b3c749411908e9aaeed1785b23789c746e5f17d11bb4c8012102deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9ffffffff0200e1f505000000000014f0d9374a2ce80c377187f4bc6c68993c561cb13600001079d717000000000014344e3a6e42f993c81486f4ee68ec687be0cf50d8000000000000",
  "confirmations": 5
}
```

### HTTP Request
`GET /tx/:txhash`

### URL Parameters
Parameter | Description
--------- | -----------
:txhash | Hash of tx.


## Get tx by address
```javascript
let address;
```

```shell--vars
address='rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap';
```

```shell--curl
curl $url/tx/address/$address
```

```shell--cli
hsd-cli tx $address
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.getTXByAddress(address);
  console.log(result);
})().catch((err) => {
  console.error(err.stack);
});
```

> The above command returns JSON structured like this:

```json
[
  {
    "hash": "4674eb87021d9e07ff68cfaaaddfb010d799246b8f89941c58b8673386ce294f",
    "witnessHash": "337189c003cf9c2ea413b5b6041c5b9e62f5fdfafcdd6cb54d5829c6cd59dd77",
    "fee": 2800,
    "rate": 20000,
    "mtime": 1528329716,
    "height": -1,
    "block": null,
    "time": 0,
    "index": -1,
    "version": 0,
    "inputs": [
      {
        "prevout": {
          "hash": "2277cbd9dd1c2552f9998e6861c7fd6866b9a48fa94ec85f03697390e8fa5d4b",
          "index": 0
        },
        "witness": [
          "ef5ae8c401a69123b69da2922514ff62a76a040abb615e79453ad8172a31916c65c82ecebf15d40678b3c749411908e9aaeed1785b23789c746e5f17d11bb4c801",
          "02deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9"
        ],
        "sequence": 4294967295,
        "coin": {
          "version": 0,
          "height": 2,
          "value": 500000000,
          "address": "rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc",
          "covenant": {
            "type": 0,
            "items": []
          },
          "coinbase": true
        }
      }
    ],
    "outputs": [
      {
        "value": 100000000,
        "address": "rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap",
        "covenant": {
          "type": 0,
          "items": []
        }
      },
      {
        "value": 399997200,
        "address": "rs1qx38r5mjzlxfus9yx7nhx3mrg00sv75xc5mksk5",
        "covenant": {
          "type": 0,
          "items": []
        }
      }
    ],
    "locktime": 0,
    "hex": "00000000012277cbd9dd1c2552f9998e6861c7fd6866b9a48fa94ec85f03697390e8fa5d4b000000000241ef5ae8c401a69123b69da2922514ff62a76a040abb615e79453ad8172a31916c65c82ecebf15d40678b3c749411908e9aaeed1785b23789c746e5f17d11bb4c8012102deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9ffffffff0200e1f505000000000014f0d9374a2ce80c377187f4bc6c68993c561cb13600001079d717000000000014344e3a6e42f993c81486f4ee68ec687be0cf50d8000000000000",
    "confirmations": 5
  }
  ...
]
```

Returns transaction objects array by address

### HTTP Request
`GET /tx/address/:address`

### URL Parameters
Parameter | Description
--------- | -----------
:address | Handshake address.

## Get tx by addresses
```javascript
let address0, address1;
```

```shell--vars
address0='rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap';
address1='rs1qx38r5mjzlxfus9yx7nhx3mrg00sv75xc5mksk5';
```

```shell--curl
 curl $url/tx/address \
  -H 'Content-Type: application/json' \
  -X POST \
  --data '{ "addresses":[ "'$address0'", "'$address1'" ]}'
```

```shell--cli
No CLI Option.
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.getTXByAddresses([address0, address1]);
  console.log(result);
})();
```

> The above command returns JSON structured like this:

```json
[
  {
    "hash": "f64f1a1bea51883ef365ac5008656f0eecedfa58c0215e97a0f2c5046ebb73c0",
    "witnessHash": "f9429e86143084392a9d23d0680bf7570ddc7e2bfe51405d44a554dbad8ab51d",
    "fee": 0,
    "rate": 0,
    "mtime": 1528329693,
    "height": 3,
    "block": "be818dc2e986f872118e2c4d2995d14beb03edada40a448d24daf7b62cc272cf",
    "time": 1528329693,
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
          "72bc06c17f58df4e",
          "0000000000000000"
        ],
        "sequence": 816606577,
        "address": null
      }
    ],
    "outputs": [
      {
        "value": 500000000,
        "address": "rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc",
        "covenant": {
          "type": 0,
          "items": []
        }
      }
    ],
    "locktime": 3,
    "hex": "00000000010000000000000000000000000000000000000000000000000000000000000000ffffffff030d6d696e65642062792068736b640872bc06c17f58df4e080000000000000000716dac30010065cd1d000000000014f039bea7884a3e8568ed967ee1f830afd5cba990000003000000",
    "confirmations": 1
  },
  {
    "hash": "4674eb87021d9e07ff68cfaaaddfb010d799246b8f89941c58b8673386ce294f",
    "witnessHash": "337189c003cf9c2ea413b5b6041c5b9e62f5fdfafcdd6cb54d5829c6cd59dd77",
    "fee": 2800,
    "rate": 20000,
    "mtime": 1528329716,
    "height": -1,
    "block": null,
    "time": 0,
    "index": -1,
    "version": 0,
    "inputs": [
      {
        "prevout": {
          "hash": "2277cbd9dd1c2552f9998e6861c7fd6866b9a48fa94ec85f03697390e8fa5d4b",
          "index": 0
        },
        "witness": [
          "ef5ae8c401a69123b69da2922514ff62a76a040abb615e79453ad8172a31916c65c82ecebf15d40678b3c749411908e9aaeed1785b23789c746e5f17d11bb4c801",
          "02deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9"
        ],
        "sequence": 4294967295,
        "coin": {
          "version": 0,
          "height": 2,
          "value": 500000000,
          "address": "rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc",
          "covenant": {
            "type": 0,
            "items": []
          },
          "coinbase": true
        }
      }
    ],
    "outputs": [
      {
        "value": 100000000,
        "address": "rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap",
        "covenant": {
          "type": 0,
          "items": []
        }
      },
      {
        "value": 399997200,
        "address": "rs1qx38r5mjzlxfus9yx7nhx3mrg00sv75xc5mksk5",
        "covenant": {
          "type": 0,
          "items": []
        }
      }
    ],
    "locktime": 0,
    "hex": "00000000012277cbd9dd1c2552f9998e6861c7fd6866b9a48fa94ec85f03697390e8fa5d4b000000000241ef5ae8c401a69123b69da2922514ff62a76a040abb615e79453ad8172a31916c65c82ecebf15d40678b3c749411908e9aaeed1785b23789c746e5f17d11bb4c8012102deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9ffffffff0200e1f505000000000014f0d9374a2ce80c377187f4bc6c68993c561cb13600001079d717000000000014344e3a6e42f993c81486f4ee68ec687be0cf50d8000000000000",
    "confirmations": 5
  }
]
```

Returns transaction objects array by addresses

### HTTP Request
`POST /tx/address`

### POST Parameters (JSON)
Parameter | Description
--------- | -----------
addresses | array of handshake addresses

