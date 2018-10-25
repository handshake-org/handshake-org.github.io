# Wallet - Admin Commands

```shell--curl
curl http://x:api-key@127.0.0.1:14039 # will access admin functions for regtest (port 14039) wallets

# examples in these docs will use an environment variable:
walletadminurl=http://x:api-key@127.0.0.1:14039/
curl $walletadminurl/<METHOD>
```

Admin commands are simply commands no specific to any particular wallet, and may
impact all wallets on the system.

Additional security is available by specifying `admin-token` in your configuration
if `wallet-auth` is also enabled. If `admin-token` is specified, add `?token=`
to all admin requests.

This is highly recommended, especially on production instances.

## Wallet Rescan
```javascript
let height;
```

```shell--vars
height=50
```

```shell--curl
curl $walletadminurl/rescan \
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
  network: network.type,
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
curl $walletadminurl/resend \
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
  network: network.type,
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

##Wallet Backup
```javascript
let path;
```

```shell--vars
path='/home/user/walletdb-backup.ldb'
```

```shell--curl
curl $walletadminurl/backup?path=$path \
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
  network: network.type,
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

## List all Wallets

```shell--curl
curl $walletadminurl/wallet
```

```shell--cli
hsw-cli wallets
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const walletOptions = {
  network: network.type,
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
