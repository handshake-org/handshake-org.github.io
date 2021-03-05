# Wallet - Admin Commands

```shell--curl
curl http://x:api-key@127.0.0.1:14039 # will access admin functions for regtest (port 14039) wallets
```

Admin commands are simply commands not specific to any particular wallet,
and may impact all wallets on the system. Retrieving a wallet's master hd
private key is also an admin command.

Additional security is available by specifying `admin-token` in your
configuration if `wallet-auth` is also enabled. If `admin-token` is specified,
add `?token=` to all admin requests.

This is highly recommended, especially on production instances.

## Wallet Rescan
```javascript
let height;
```

```shell--vars
height=50
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/rescan \
  -X POST \
  --data '{"height": '$height'}'
```

```shell--cli
hsw-cli rescan $height
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

(async () => {
  const result = await walletClient.rescan(height);
  console.log(result);
})();

```

> Response Body:

```json
{"success": true}
```

Initiates a blockchain rescan for the walletdb. Wallets will be rolled back to the specified height (transactions above this height will be unconfirmed).

### Example HTTP Request
`POST /rescan?height=50`

## Wallet Resend
```shell--curl
curl http://x:api-key@127.0.0.1:14039/resend \
-X POST
```

```shell--cli
hsw-cli resend
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

(async () => {
  result = await walletClient.resend();
  console.log(result);
})();
```

> Response Body:

```json
    {"success": true}
```

Rebroadcast all pending transactions in all wallets.

### HTTP Request

`POST /resend`

## Wallet Backup
```javascript
let path;
```

```shell--vars
path='/home/user/walletdb-backup.ldb'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/backup?path=$path \
  -X POST
```

```shell--cli
hsw-cli backup $path
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

(async () => {
  const result = await walletClient.backup(path);
  console.log(result);
})();
```

> Response Body:

```json
{"success": true}
```

Safely backup the wallet database to specified path (creates a clone of the database).

### HTTP Request

`POST /backup?path=/home/user/walletdb-backup.ldb`

## Wallet Master HD Private Key
```javascript
let id;
```
```shell--vars
id='primary'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/$id/master
```

```shell--cli
hsw-cli master --id=$id
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
  const result = await wallet.getMaster();
  console.log(result);
})();
```

> Sample responses:

> BEFORE passphrase is set:

```json
{
  "encrypted": false,
  "key": {
    "xprivkey": "tprv8ZgxMBicQKsPe7977psQCjBBjWtLDoJVPiiKog42RCoShJLJATYeSkNTzdwfgpkcqwrPYAmRCeudd6kkVWrs2kH5fnTaxrHhi1TfvgxJsZD",
    "mnemonic": {
      "bits": 128,
      "language": "english",
      "entropy": "a560ac7eb5c2ed412a4ba0790f73449d",
      "phrase": "pistol air cabbage high conduct party powder inject jungle knee spell derive"
    }
  }
}
```

> AFTER passphrase is set:

```json
{
  "encrypted": true,
  "until": 1527121890,
  "iv": "e33424f46674d4010fb0715bb69abc98",
  "ciphertext": "c2bd62d659bc92212de5d9e939d9dc735bd0212d888b1b04a71d319e82e5ddb18008e383130fd0409113264d1cbc0db42d997ccf99510b168c80e2f39f2983382457f031d5aa5ec7a2d61f4fc92c62117e4eed59afa4a17d7cb0aae3ec5fa0d4",
  "algorithm": "pbkdf2",
  "n": 50000,
  "r": 0,
  "p": 0
}
```

Export the wallet's master hd private key. This is normally censored in the
wallet info route. The provided API key must have admin access.
<aside class="warning">
Once a passphrase has been set for a wallet, the API will not reveal the
unencrypted master hd private key or seed phrase. Be sure you back it up
right away!
</aside>

### HTTP Request

`GET /wallet/:id/master`

Parameters | Description
---------- | -----------
id <br> _string_ | wallet id

## List all Wallets

```shell--curl
curl http://x:api-key@127.0.0.1:14039/wallet
```

```shell--cli
hsw-cli wallets
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

(async () => {
  const result = await walletClient.getWallets();
  console.log(result);
})();
```

> Sample Response Body:

```json
[
  "primary",
  "newWallet",
  "multisig1",
  "multisig2",
  "watchonly1",
  "multisig3",
  "witness1"
]
```

List all wallet IDs. Returns an array of strings.

### HTTP Request

`GET /wallet`
