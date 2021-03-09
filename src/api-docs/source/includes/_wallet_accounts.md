# Wallet - Accounts
## Account Object
> An account object looks like this:

```json
{
  "name": "default",
  "initialized": true,
  "watchOnly": false,
  "type": "pubkeyhash",
  "m": 1,
  "n": 1,
  "accountIndex": 0,
  "receiveDepth": 5,
  "changeDepth": 7,
  "lookahead": 10,
  "receiveAddress": "rs1qy9uplxpt5cur32rw3zmyf8e7tp87w8slly2fms",
  "changeAddress": "rs1q30ppv5gyrwpy4wyk0v6uzawxygdtvrpux8yrg2",
  "accountKey": "rpubKBAXPkng2Zk4FTt7GwatsRAivjckuySyYydDXhcDFKvvQXN4wDvMtazgTAzq7gHA4ZcyXJp5VoYE8AcacXc1AgNmrnJt1YuAkbovBRSJ4Fuo",
  "keys": [],
  "balance": {
    "tx": 10,
    "coin": 10,
    "unconfirmed": 2499997200,
    "confirmed": 2500000000,
    "lockedUnconfirmed": 0,
    "lockedConfirmed": 0
  }
}
```
Represents a BIP44 Account belonging to a Wallet.
Note that this object does not enforce locks. Any method that does a write is internal API only and will lead to race conditions if used elsewhere.

From the [BIP44 Specification](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki):

        *This level splits the key space into independent user identities, so the wallet never mixes the coins across different accounts.*
        *Users can use these accounts to organize the funds in the same fashion as bank accounts; for donation purposes (where all addresses are considered public), for saving purposes, for common expenses etc.*
        *Accounts are numbered from index 0 in sequentially increasing manner. This number is used as child index in BIP32 derivation.*
        *Hardened derivation is used at this level.*

<aside class="warning">
Accounts within the same wallet are all related by deterministic hierarchy. However, wallets are not related to each other in any way. This means that when a wallet seed is backed up, all of its accounts (and their keys) can be derived from that backup. However, each newly created wallet must be backed up separately.
</aside>

## Get Wallet Account List

```shell--vars
id='primary'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/wallet/$id/account
```

```shell--cli
hsw-cli account --id=$id list
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
  const result = await wallet.getAccounts();
  console.log(result);
})();
```

> Sample response:

```json
[
  "default"
]
```

List all account names (array indices map directly to bip44 account indices) associated with a specific wallet id.

### HTTP Request

`GET /wallet/:id/account`


Parameters | Description
---------- | -----------
id <br> _string_ | id of wallet you would like to retrieve the account list for

<aside class="notice">
Note that command defaults to primary (default) wallet if no wallet id is passed
</aside>

## Get Account Information
```javascript
let id, account;
```

```shell--vars
id='primary'
account='default'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/wallet/$id/account/$account
```

```shell--cli
hsw-cli --id=$id account get $account
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
  const result = await wallet.getAccount(account);
  console.log(result);
})();
```

> Sample response:

```json
{
  "name": "default",
  "initialized": true,
  "watchOnly": false,
  "type": "pubkeyhash",
  "m": 1,
  "n": 1,
  "accountIndex": 0,
  "receiveDepth": 6,
  "changeDepth": 9,
  "nestedDepth": 0,
  "lookahead": 10,
  "receiveAddress": "RLY9z6PCB3fggt36mnfA75jESRtvkALKX5",
  "changeAddress": "RPSppa2YUzTK5jWWZ7k74NfMEJtnNKn4vs",
  "nestedAddress": null,
  "accountKey": "rpubKBBuJXusEYaDdxTwH1nPYRXQnd3XgLAFfNYxVhjrtvLAkDAXaps1nURZVmWuFsXK8RBXiDQu7grCBv6fRtQxgPH3FkKe4UQV7F2sfNBK47sA",
  "keys": [],
  "balance": {
    "tx": 505,
    "coin": 501,
    "unconfirmed": 1339989996774,
    "confirmed": 1339989999000
  }
}
```

Get account info.

### HTTP Request

`GET /wallet/:id/account/:account`

Parameters | Description
---------- | -----------
id <br> _string_ | id of wallet you would like to query
account <br> _string_ | id of account you would to retrieve information for

## Create new wallet account

```javascript
let id, passphrase, name, type;
```

```shell--vars
id='primary'
passphrase='secret123'
name='menace'
type='multisig'
```

```shell--cli
hsw-cli --id=$id account create --name=$name --type=$type --passphrase=$passphrase 
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039/wallet/$id/account/$name \
    -X PUT \
    --data '{"type": "'$type'", "passphrase": "'$passphrase'"}'
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
const options = {name: name, type: type, passphrase: passphrase}

(async () => {
  const result = await wallet.createAccount(name, options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "name": "null",
  "initialized": true,
  "watchOnly": false,
  "type": "pubkeyhash",
  "m": 1,
  "n": 1,
  "accountIndex": 1,
  "receiveDepth": 1,
  "changeDepth": 1,
  "lookahead": 10,
  "receiveAddress": "rs1qnkc22uz2hp9qz8tphyqy8ujftmz0zstrwn6lju",
  "changeAddress": "rs1qk6me5r699v24jn4u9jhdwxg4cykn2akr89g59p",
  "accountKey": "rpubKBAXPkng2Zk4FX87zf5LehvNn7Hy5P4eVwKp58YZ1CV7uZwgbDd1PHPKuyj7UTnvzFMMziK2kGtqMpZaKa6zUUM7YBsUB6pzQtojUFM4dnQM",
  "keys": [],
  "balance": {
    "tx": 0,
    "coin": 0,
    "unconfirmed": 0,
    "confirmed": 0,
    "lockedUnconfirmed": 0,
    "lockedConfirmed": 0
  }
}
```

Create account with specified account name.

### HTTP Request

`PUT /wallet/:id/account/:name`

### Options object
Parameter | Description
--------- | -----------------
name <br> _string_ | name to give the account. Option can be `account` or `name`
accountKey <br> _string_ | the extended public key for the account. This is ignored for non watch only wallets. Watch only accounts can't accept private keys for import (or sign transactions)
type <br> _string_ | what type of wallet to make it ('multisig', 'pubkeyhash')
m <br> _int_ | for multisig accounts, what to make `m` in m-of-n
n <br> _int_ | for multisig accounts, what to make the `n` in m-of-n
