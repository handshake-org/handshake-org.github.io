# Wallet Transactions

## Get Wallet TX Details

```javascript
let id, hash
```

```shell--vars
id="primary"
hash="580d7de114490f623fe6cc395540be80495e6cb5b0f5a176df89325465d789b9"
```

```shell--cli
hwallet-cli --id=$id tx $hash
```

```shell--curl
curl $walleturl/$id/tx/$hash
```

```javascript
const {WalletClient} = require('hsk-client');
const {Network} = require('hskd');
const network = Network.get('regtest');

const walletOptions = {
  network: network.type,
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
curl $walleturl/$id/tx/$hash \
  -X DELETE
```

```javascript
 // Not available in javascript wallet client.
```

Abandon single pending transaction. Confirmed transactions will throw an error.
`"TX not eligible"`

### HTTP Request

`DEL /wallet/:id/tx/:hash`

Paramters | Description
----------| --------------------
id <br> _string_ | id of wallet where the transaction is that you want to remove
hash <br> _string_ | hash of transaction you would like to remove.

## Get Wallet TX History

```javascript
let id;
```

```shell--vars
id='primary'
```

```shell--cli
hwallet-cli --id=$id history
```

```shell--curl
curl $walleturl/$id/tx/history
```

```javascript
const {WalletClient} = require('hsk-client');
const {Network} = require('hskd');
const network = Network.get('regtest');

const walletOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);
const account = 'default';

(async () => {
  const result = await wallet.getHistory(account);
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

Get wallet TX history. Returns array of tx details.

### HTTP Request
`GET /wallet/:id/tx/history`

### Request Parameters
Paramter | Description
-------- | -------------------------
id <br> _string_ | id of wallet to get history of

## Get Pending Transactions

```javascript
let id;
```

```shell--vars
id='primary'
```

```shell--cli
hwallet-cli --id=$id pending
```

```shell--curl
curl $walleturl/$id/tx/unconfirmed
```

```javascript
const {WalletClient} = require('hsk-client');
const {Network} = require('hskd');
const network = Network.get('regtest');

const walletOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getPending();
  console.log(result);
})();
```

Get pending wallet transactions. Returns array of tx details.

### HTTP Request

`GET /wallet/:id/tx/unconfirmed`

### Request Parameters
Paramter | Description
-------- | -------------------------
id <br> _string_ | id of wallet to get pending/unconfirmed txs


## Get Range of Transactions
```javascript
let id, account, start, end;
```

```shell--vars
id="primary"
account="default"
start="1527184612"
end="1527186612"
```

```shell--cli
# range not available in CLI
```

```shell--curl
curl $walleturl/$id/tx/range?start=$start'&'end=$end
```

```javascript
const {WalletClient} = require('hsk-client');
const {Network} = require('hskd');
const network = Network.get('regtest');

const walletOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getRange(account, {start: start, end: end});
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
  }
  ...
]
```
Get range of wallet transactions by timestamp. Returns array of tx details.

<aside class="notice">
Note that there are other options documented that `getRange` accepts in the options body, `limit` and `reverse`. At the time of writing however they do not have any effect.
</aside>

### HTTP Request

`GET /wallet/:id/tx/range`

### Body Parameters
Paramter | Description
-------- | -------------------------
account <br>_string_ | account to get the tx history from
start <br> _int_ | start time to get range from
end <br> _int_ | end time to get range from

<!-- ##GET /wallet/:id/tx/last

Get last N wallet transactions.

### HTTP Request

`GET /wallet/:id/tx/last` -->
