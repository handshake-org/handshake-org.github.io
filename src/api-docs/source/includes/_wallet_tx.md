# Wallet - Transactions

## Get Wallet TX Details

```javascript
let id, hash
```

```shell--vars
id="primary"
hash="580d7de114490f623fe6cc395540be80495e6cb5b0f5a176df89325465d789b9"
```

```shell--cli
hsw-cli --id=$id tx $hash
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/wallet/$id/tx/$hash
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const walletOptions = {
  port: network.walletPort,
  apiKey: 'api-key'
}

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getTX(hash);
  console.log(result);
})();
```
> Sample Response

```json
{
  "hash": "580d7de114490f623fe6cc395540be80495e6cb5b0f5a176df89325465d789b9",
  "height": 5,
  "block": "ae127a29c02d7b13ed0a3d57f913392a7f8f82b50295970585cbfad8bc6577b2",
  "time": 1528427154,
  "mtime": 1528427143,
  "date": "2018-06-08T03:05:54Z",
  "mdate": "2018-06-08T03:05:43Z",
  "size": 215,
  "virtualSize": 140,
  "fee": 2800,
  "rate": 20000,
  "confirmations": 1,
  "inputs": [
    {
      "value": 500000000,
      "address": "rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc",
      "path": {
        "name": "default",
        "account": 0,
        "change": false,
        "derivation": "m/0'/0/0"
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
      },
      "path": {
        "name": "default",
        "account": 0,
        "change": false,
        "derivation": "m/0'/0/1"
      }
    },
    {
      "value": 399997200,
      "address": "rs1q5rjhy20r2hmcxjpc8zv70xkck05pecdew6a798",
      "covenant": {
        "type": 0,
        "items": []
      },
      "path": {
        "name": "default",
        "account": 0,
        "change": true,
        "derivation": "m/0'/1/1"
      }
    }
  ],
  "tx": "0000000001b724ff8521fd9e7b86afc29070d52e9709927a6c8023360ea86d906f8ea6dcb300000000024126538396dcf0a498bdcebc40f09e17ac7e36f28dead9cecbdcb2fcbb1d64bc241de35734009b4bbf0363578191b56e7bb391b10ff24ccdf9db77e9d291978714012102deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9ffffffff0200e1f505000000000014f0d9374a2ce80c377187f4bc6c68993c561cb13600001079d717000000000014a0e57229e355f78348383899e79ad8b3e81ce1b9000000000000"
}
```
Get wallet transaction details.

### HTTP Request

`GET /wallet/:id/tx/:hash`

### Request Parameters
Parameter | Description
--------- | --------------
id <br> _string_ | id of wallet that handled the transaction
hash <br> _string_ | hash of the transaction you're trying to retrieve

## Delete Transaction
```javascript
let id, hash, passphrase;
```

```shell--vars
id="primary"
hash="a97a9993389ae321b263dffb68ba1312ad0655da83aeca75b2372d5abc70544a"
```

```shell--cli
# Not available in CLI
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/wallet/$id/tx/$hash \
  -X DELETE
```

```javascript
 // Not available in javascript wallet client.
```

Abandon single pending transaction. Confirmed transactions will throw an error.
`"TX not eligible"`

### HTTP Request

`DEL /wallet/:id/tx/:hash`

Parameters         | Description
------------------ | --------------------
id <br> _string_   | id of wallet where the transaction is that you want to remove
hash <br> _string_ | hash of transaction you would like to remove.

## Get Wallet TX History

```javascript
let id, limit, time, reverse;
```

```shell--vars
id='primary'
limit=5
time=1736413154
reverse=true
```

```shell--cli
hsw-cli --id=$id history --limit=$limit --time=$time --reverse=$reverse
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/wallet/$id/tx/history?limit=$limit&time=$time&reverse=$reverse
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const walletOptions = {
  port: network.walletPort,
  apiKey: 'api-key'
}

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);
const account = 'default';

(async () => {
  const options = {
    limit,
    time,
    reverse
  };
  const result = await wallet.getHistory(options);
  console.log(result);
})();
```
> Sample Response

```json
[
  {
    "hash": "bc0f93bb233fdf42a25a086ffb744fcb4f64afe6f5d4243da8e3745835fd57b3",
    "height": -1,
    "block": null,
    "time": 0,
    "mtime": 1528468930,
    "date": "1970-01-01T00:00:00Z",
    "mdate": "2018-06-08T14:42:10Z",
    "size": 215,
    "virtualSize": 140,
    "fee": 2800,
    "rate": 20000,
    "confirmations": 0,
    "inputs": [
      {
        "value": 500002800,
        "address": "rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc",
        "path": {
          "name": "default",
          "account": 0,
          "change": false,
          "derivation": "m/0'/0/0"
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
        },
        "path": {
          "name": "default",
          "account": 0,
          "change": false,
          "derivation": "m/0'/0/1"
        }
      },
      {
        "value": 400000000,
        "address": "rs1q2x2suqr44gjn2plm3f99v2ae6ead3rpat9qtzg",
        "covenant": {
          "type": 0,
          "items": []
        },
        "path": {
          "name": "default",
          "account": 0,
          "change": true,
          "derivation": "m/0'/1/4"
        }
      }
    ],
    "tx": "0000000001758758e600061e62b92831cb40163011e07bd42cac34467f7d34f57c4a921e35000000000241825ebb96f395c02d3cdce7f88594dab343347879dd96af29320bf020f2c5677d4ab7ef79349007d562a4cdafb54d8e1cbd538275deef1b78eb945155315ae648012102deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9ffffffff0200e1f505000000000014f0d9374a2ce80c377187f4bc6c68993c561cb13600000084d71700000000001451950e0075aa253507fb8a4a562bb9d67ad88c3d000000000000"
  },
 ...
]
```

Get wallet transaction history chronologically (oldest to newest, unless reversed), including both confirmed and pending transactions. Returns an array of transaction details.

### HTTP Request
`GET /wallet/:id/tx/history`

Parameter        | Description
---------------- | -----------
id <br> _string_ | Wallet ID

### Query Parameters

Parameter             | Default   | Description
--------------------- | -------   | -----------
account <br> _string_ | Optional  | Account name to filter transactions. All TXs by default.
after <br> _hex_      | Optional  | List transactions after this tx hash
time <br> _int_       | Optional  | List transactions after this timestamp in epoch seconds, used if `after` is not specified.
limit <br> _int_      | `maxTXs`* | Maximum number of transactions to return
reverse <br> _bool_   | `false`   | TX Ordering, whether it should reverse the chronological order (oldest to newest)

Notes:

  - When using `time`, the timestamp is indexed based on median-time-past (MTP).
  - *`maxTXs` refers to wallet `maxHistoryTXs` configuration.
  - `limit` can not exceed `maxHistoryTXs` configuration.

## Get Pending Transactions

```javascript
let id, limit, after, reverse;
```

```shell--vars
id='primary'
limit=5
reverse=true
after='6cfd18f4e5810cc4285964df3cda75b8249d336e3544c2db9b30f066d349d0cc'
```

```shell--cli
hsw-cli --id=$id pending --limit=$limit --after=$after --reverse=$reverse
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/wallet/$id/tx/unconfirmed?limit=$limit&after=$after&reverse=$reverse
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const walletOptions = {
  port: network.walletPort,
  apiKey: 'api-key'
}

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const options = {
    limit,
    reverse,
    after
  };
  const result = await wallet.getPending(options);
  console.log(result);
})();
```

> Sample Response

```json
[
  {
    "hash": "57dd1e1b306de8da08d38b68b77e239bffe6d6b0b32bd734cf72684c21a03068",
    "height": -1,
    "block": null,
    "time": 0,
    "mtime": 1736411031,
    "date": "1970-01-01T00:00:00Z",
    "mdate": "2025-01-09T08:23:51Z",
    "size": 215,
    "virtualSize": 140,
    "fee": 0,
    "rate": 0,
    "confirmations": 0,
    "inputs": [
      {
        "value": 0,
        "address": "rs1qannv3v0wacekpsfk9ysa2p7mnepd86c63543sh",
        "path": null
      }
    ],
    "outputs": [
      {
        "value": 9000000,
        "address": "rs1qgjpc0kpty45za0dwdf4jgqmw9e3yjtej3gvadw",
        "covenant": {
          "type": 0,
          "action": "NONE",
          "items": []
        },
        "path": {
          "name": "default",
          "account": 0,
          "change": false,
          "derivation": "m/0'/0/2"
        }
      },
      {
        "value": 1990997200,
        "address": "rs1qpaf5s2qyl8pyu0upgpq95m68kfp7gnflgcscsr",
        "covenant": {
          "type": 0,
          "action": "NONE",
          "items": []
        },
        "path": null
      }
    ],
    "tx": "00000000013e298505af6b7176afedcaa25528e0b118f263a7e0fff2318eb62800dc07497400000000ffffffff0240548900000000000014448387d82b25682ebdae6a6b24036e2e62492f320000d034ac760000000000140f53482804f9c24e3f8140405a6f47b243e44d3f000000000000024156129fcf21f7de6a7e4b62569b050495e1168c7a69f5e8db6dc37c41d216e3ed27842585b94fa353108981671068989a0b742225f3c93bfc4838352a165fefce0121027a7e5e2e8a0447e7e76d27247af1a7c2b2c19fbd3dc77512a8ee96dc3612c453"
  },
  ...
]
```

Get pending (unconfirmed) wallet transactions chronologically (oldest to newest, unless reversed). Returns an array of transaction details.

### HTTP Request

`GET /wallet/:id/tx/unconfirmed`

Parameter        | Description
---------------- | -----------
id <br> _string_ | Wallet ID

### Query Parameters
Parameter             | Default   | Description
--------------------- | --------  | -----------
account <br> _string_ | None      | Account name to filter transactions
after <br> _hex_      | Optional  | List transactions after this tx hash
time <br> _int_       | Optional  | List transactions after this timestamp in epoch seconds, used if `after` is not specified.
limit <br> _int_      | `maxTXs`* | Maximum number of transactions to return
reverse <br> _bool_   | `false`   | TX Ordering, whether it should reverse the chronological order (oldest to newest)

Notes:

  - For unconfirmed transactions, the `time` parameter is based on when the transaction was added to the wallet.
  - *`maxTXs` refers to wallet `maxHistoryTXs` configuration
  - `limit` can not exceed `maxHistoryTXs` configuration
