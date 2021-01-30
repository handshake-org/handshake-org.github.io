# RPC Calls - Wallet

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "<method>", "params": [...] "id": "some-id" }'
```

```shell--cli
hsw-cli rpc <method> <params>
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
  const result = await walletClient.execute('<method>', [ <params> ]);
  console.log(result);
})();
```
Like the [hsd node RPC calls](#rpc-calls-node), the wallet RPC calls mimic Bitcoin Core's RPC.

Refer to the sections on [the wallet client](#the-wallet-client) and [the wallet db object](#the-walletdb-and-object)
for host, port, and authentication information.

RPC Calls are accepted at:
`POST /`

### wallet RPC POST Parameters
Parameter | Description
--------- | -----------
method  | Name of the RPC call
params  | Parameters accepted by method
id      | `int` Will be returned with the response (cURL only)

<aside class='warning'>
A note about the <code>label</code> parameter:<br>
These RPC calls were designed to be backwards-compatible with Bitcoin Core, which has the option
to label addresses. hsd ignores this parameter because it does not label addresses.
To match the order and sequence of RPC parameters with Bitcoin Core, a <code>label</code>
parameter MUST be passed in certain RPC calls, even though it will be ignored by hsd.
The following calls are affected:<br>
<code><a href="#importprivkey">importprivkey</a></code><br>
<code><a href="#importaddress">importaddress</a></code><br>
<code><a href="#importpubkey">importpubkey</a></code><br>
<code><a href="#importprunedfunds">importprunedfunds</a></code><br>
<code><a href="#sendmany">sendmany</a></code><br>
<code><a href="#sendtoaddress">sendtoaddress</a></code>
</aside>



## selectwallet

```javascript
let id;
```

```shell--vars
id='primary'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "selectwallet",
    "params": [ "'$id'" ]
  }'
```

```shell--cli
hsw-cli rpc selectwallet $id
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
  const result = await walletClient.execute('selectwallet', [id]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Switch target wallet for all future RPC calls.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | id | Required | id of selected wallet



## getwalletinfo

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "getwalletinfo" }'
```

```shell--cli
hsw-cli rpc getwalletinfo
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
  const result = await walletClient.execute('getwalletinfo');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "result": {
    "walletid": "primary",
    "walletversion": 6,
    "balance": 50,
    "unconfirmed_balance": 50,
    "txcount": 1,
    "keypoololdest": 0,
    "keypoolsize": 0,
    "unlocked_until": 0,
    "paytxfee": 0,
    "height": 50
  },
  "error": null,
  "id": null
}
```

Get basic wallet details.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## fundrawtransaction

```javascript
let tx;
let options={"changeAddress": "rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3", "feeRate": 0.001000};
```

```shell--vars
tx='0100000000024e61bc00000000001976a914fbdd46898a6d70a682cbd34420ccf0b6bb64493788acf67e4929010000001976a9141b002b6fc0f457bf8d092722510fce9f37f0423b88ac00000000'
```

```shell--curl
options='{"changeAddress": "rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3", "feeRate": 0.001000}'

curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "fundrawtransaction",
    "params": [ "'$tx'", '"$options"']
  }'
```

```shell--cli
options='{"changeAddress": "rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3", "feeRate": 0.001000}'

hsw-cli rpc fundrawtransaction $tx "$options"
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
  const result = await walletClient.execute('fundrawtransaction', [tx, options]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

<!---
########
#  TODO: Currently this method does not work: https://github.com/bcoin-org/bcoin/issues/521
########
-->

```json

```

Add inputs to a transaction until it has enough in value to meet its out value.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | hexstring | Required | raw transaction
2 | options | Optional | Object containing options

### Options
Option | Description
---- | ----
feeRate | Sets fee rate for transaction in HNS/kb
changeAddress | Handshake address for change output of transaction



## resendwallettransactions

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "resendwallettransactions" }'
```

```shell--cli
hsw-cli rpc resendwallettransactions
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
  const result = await walletClient.execute('resendwallettransactions');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  "147c2527e2bb7ddfa855cc4b933ab288e05aa7816c487db69db344971f1b0951",
  "c3c92d6686442755d70d2ea44401437d9fab51bc7a504b041d6d6b950ba45e85",
  "77f09f2f307aaa62c8d36a9b8efeac368381c84ebd195e8aabc8ba3023ade390",
  "2c0fa5740c494e8c86637c1fad645511d0379d3b6f18f84c1e8f7b6a040a399c",
  "ef38a6b68afe74f637c1e1bc605f7dc810ef50c6f475a0a978bac9546cac25d8",
  "1146d21bb5c46f1de745d9def68dafe97bbf917fe0f32cef31937731865f10e9"
]
```

Re-broadcasts all unconfirmed transactions to the network.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## abandontransaction

```javascript
let tx;
```

```shell--vars
tx='a0a65cd0508450e8acae76f35ae622e7b1e7980e95f50026b98b2c6e025dae6c'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "abandontransaction",
    "params": [ "'$tx'" ]
  }'
```

```shell--cli
hsw-cli rpc abandontransaction $tx
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
  const result = await walletClient.execute('abandontransaction', [tx]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Remove transaction from the database. This allows "stuck" coins to be respent.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txid | Required | Transaction ID to remove


## backupwallet

```javascript
let path;
```

```shell--vars
path='/home/user/WalletBackup'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "backupwallet",
    "params": [ "'$path'" ]
  }'
```

```shell--cli
hsw-cli rpc backupwallet $path
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
  const result = await walletClient.execute('backupwallet', [path]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Back up wallet database and files to directory created at specified path.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | path | Required | Absolute path (including directories and filename) to write backup file



## dumpprivkey

```javascript
let address;
```

```shell--vars
address='rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "dumpprivkey",
    "params": [ "'$address'" ]
  }'
```

```shell--cli
hsw-cli rpc dumpprivkey $address
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
  const result = await walletClient.execute('dumpprivkey', [address]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
cNRiqwzRfcUfokNV8nSnDKb3NsKPhfRV2z5kBN11GKFb3GXkk1Hj
```

Get the private key (WIF format) corresponding to specified address.
Also see [importprivkey](#importprivkey)

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Reveal the private key for this Handshake address 



## dumpwallet

```javascript
let path;
```

```shell--vars
path='/home/user-1/secretfiles/dump1.txt'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "dumpwallet",
    "params": [ "'$path'" ]
  }'
```

```shell--cli
hsw-cli rpc dumpwallet $path
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
  const result = await walletClient.execute('dumpwallet', [path]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

> The contents of the wallet dump file are formatted like this:

```
# Wallet Dump created by hsd 2.0.1
# * Created on 2019-10-22T18:29:15Z
# * Best block at time of backup was 845 (72365e9f4b4ed638bb1600116a67e3fa59b6ad6be2a449b675db607a984da4f8).
# * File: /home/user-1/secretfiles/dump1.txt

cNUUoZYmUGoJyodrNaohzfu6LmKy7pBk6yqubJcTeL5WPWw97DQ1 2019-10-22T18:29:15Z label= addr=mg54SV2ZubNQ5urTbd42mUsQ54byPvSg5j
cNH7YBw6haTB3yWkAndoPhwXRLNibXjWAYpqRQdvqPKLeW7JAj6h 2019-10-22T18:29:15Z change=1 addr=mgj4oGTbvCHxvx4EESYJKPkXWamxh2R6ef
cNmBeL4kpjLtNZcvjSezftq4ks6ajzZRi1z2AGpuBGy6XjxzytiQ 2019-10-22T18:29:15Z label= addr=mhX1xHbKGzw3r8FoN5bUkmRixHPEDNywxh
cUEfRrvPpKCy87QReCmPmd74Hz68kgZEHAErkuvEDFqwJKcCLsMn 2019-10-22T18:29:15Z label= addr=mhcx3M1AitoiwDQS3sz42CQLpVCEVkJLfq
cP4N8mxe81DhZfrgTz2GoV3croXD2o6Hern4DTB6Gr5jUwoLkT8h 2019-10-22T18:29:15Z change=1 addr=mhpSYq8bnM5XJVbpafdLNUtLZefr2d6xSq
...

# End of dump
```

Creates a new human-readable file at specified path with all wallet private keys in 
Wallet Import Format (base58).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | path | Required | Absolute path (including directories and filename) to write backup file



## encryptwallet

```javascript
let passphrase;
```

```shell--vars
passphrase='bikeshed'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "encryptwallet",
    "params": [ "'$passphrase'" ]
  }'
```

```shell--cli
hsw-cli rpc encryptwallet $passphrase
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
  const result = await walletClient.execute('encryptwallet', [passphrase]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
wallet encrypted; we do not need to stop!
```

Encrypts wallet with provided passphrase.
This action can only be done once on an unencrypted wallet.
See [walletpassphrasechange](#walletpassphrasechange) or [change passphrase](#change-passphrase)
if wallet has already been encrypted.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | passphrase | Required | Strong passphrase with which to encrypt wallet



## getaccountaddress

```javascript
let account;
```

```shell--vars
account='default'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "getaccountaddress",
    "params": [ "'$account'" ]
  }'
```

```shell--cli
hsw-cli rpc getaccountaddress $account
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
  const result = await walletClient.execute('getaccountaddress', [account]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3
```

Get the current receiving address for specified account.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | account | Required | Account to retrieve address from



## getaccount

```javascript
let address;
```

```shell--vars
address='rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "getaccount",
    "params": [ "'$address'" ]
  }'
```

```shell--cli
hsw-cli rpc getaccount $address
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
  const result = await walletClient.execute('getaccount', [address]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
default
```

Get the account associated with a specified address.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Address to search for



## getaddressesbyaccount

```javascript
let account;
```

```shell--vars
account='default'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "getaddressesbyaccount",
    "params": [ "'$account'" ]
  }'
```

```shell--cli
hsw-cli rpc getaddressesbyaccount $account
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
  const result = await walletClient.execute('getaddressesbyaccount', [account]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  "rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3",
  "rs1qkk62444euknkya4qws9cg3ej3au24n635n4qye",
  "rs1q9jd8fgq8xa0drggyd6azggpeslacdzx5gr04ss",
  ...
]
```

Get all addresses for a specified account.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | account | Required | Account name



## getbalance

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "getbalance" }'
```

```shell--cli
hsw-cli rpc getbalance 
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
  const result = await walletClient.execute('getbalance');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
50.012058
```

Get total balance for entire wallet or a single, specified account.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | account | Optional | Account name



## getnewaddress

```javascript
let account;
```

```shell--vars
account='default'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "getnewaddress",
    "params": [ "'$account'" ]
  }'
```

```shell--cli
hsw-cli rpc getnewaddress $account
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
  const result = await walletClient.execute('getnewaddress', [account]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3
```

Get the next receiving address from specified account, or `default` account.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | account | Optional | Account name



## getrawchangeaddress

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "getrawchangeaddress" }'
```

```shell--cli
hsw-cli rpc getrawchangeaddress
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
  const result = await walletClient.execute('getrawchangeaddress');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3
```

Get the next change address from specified account.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getreceivedbyaccount

```javascript
let account, minconf;
```

```shell--vars
account='default'
minconf=6
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "getreceivedbyaccount",
    "params": [ "'$account'", '$minconf' ]
  }'
```

```shell--cli
hsw-cli rpc getreceivedbyaccount $account $minconf
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
  const result = await walletClient.execute('getreceivedbyaccount', [account, minconf]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
50.001234
```

Get total amount received by specified account. 
Optionally only count transactions with `minconf` number of confirmations.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | account | Required | Account name
2 | minconf | Optional | Only include transactions with this many confirmations




## getreceivedbyaddress

```javascript
let address, minconf;
```

```shell--vars
address='rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3'
minconf=6
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "getreceivedbyaddress",
    "params": [ "'$address'", '$minconf' ]
  }'
```

```shell--cli
hsw-cli rpc getreceivedbyaddress $address $minconf
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
  const result = await walletClient.execute('getreceivedbyaddress', [address, minconf]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
50.001234
```

Get total amount received by specified address. 
Optionally only count transactions with `minconf` number of confirmations.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Address to request balance of
2 | minconf | Optional | Only include transactions with this many confirmations



## gettransaction

```javascript
let address, minconf;
```

```shell--vars
txid='36cbb7ad0cc98ca86640a04c485f164dd741c20339af34516d359ecba2892c21'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "gettransaction",
    "params": [ "'$txid'" ]
  }'
```

```shell--cli
hsw-cli rpc gettransaction $txid
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
  const result = await walletClient.execute('gettransaction', [txid]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "amount": 0,
  "blockhash": "5c00755bf5b4cede330ae0f1ec68e0656d1c576ff4cdfed4404dc9d6fac5641c",
  "blocktime": 1580999686,
  "txid": "1e426d5914f2dcac62ac1eba1bd4e4c7d070a08802acf1ec3cc85ef580f18609",
  "walletconflicts": [],
  "time": 1580997713,
  "timereceived": 1580997713,
  "bip125-replaceable": "no",
  "details": [
    {
      "account": "default",
      "address": "rs1qqf90c9tycnr74ahvtdjhv7jfxa6vwxjqmepymv",
      "category": "receive",
      "amount": 0,
      "label": "default",
      "vout": 0
    }
  ],
  "hex": "0000000001575b771894c8be6da7fe86111190b97cf30333cccc8ea7d33fcad2733bf25bea00000000ffffffff0200000000000000000014024afc1564c4c7eaf6ec5b65767a493774c71a40020320e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a0400000000056272656164c498357700000000001488dbfe1341aff133fed3e9ac26c5fa37c3591c0b0000000000000241b9c26b6583117bfbfae894052336139a5233a1903b53e0fe9346eed546c7ea7d7c8833d320860ea315dd854fcd1c99201223f787cf8619b158acbc76b976d711012102737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
}
```

Get details about a transaction in the wallet.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txid | Required | ID of transaction to fetch
2 | watchonly | Optional | (bool) Whether to include watch-only addresses in balance details



## getunconfirmedbalance

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "getunconfirmedbalance" }'
```

```shell--cli
hsw-cli rpc getunconfirmedbalance
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
  const result = await walletClient.execute('getunconfirmedbalance');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
50
```

Get the unconfirmed balance from the wallet.
<aside class="notice">
In hsd balances, <code>confirmed</code> refers to the total balance of coins
confirmed in the blockchain. <code>unconfirmed</code> refers to that total
IN ADDITION to any transactions still unconfirmed in the mempool.
Another way to think about it is your <code>unconfirmed</code> balance is the
FUTURE total value of your wallet after everything is confirmed.
</aside>

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## importprivkey

```javascript
let key, label, rescan;
```

```shell--vars
key='cNH7YBw6haTB3yWkAndoPhwXRLNibXjWAYpqRQdvqPKLeW7JAj6h'
label='this_is_ignored'
rescan=false
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "importprivkey",
    "params": [ "'$key'", "'$label'", '$rescan' ]
  }'
```

```shell--cli
hsw-cli rpc importprivkey $key $label $rescan
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
  const result = await walletClient.execute('importprivkey', [key, label, rescan]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Import a private key into wallet. Also see [dumpprivkey](#dumpprivkey).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | key | Required | Private key to import (WIF format)
2 | label | Optional | [Ignored but required if additional parameters are passed](#rpc-calls-wallet)
3 | rescan | Optional | (bool) Whether to rescan wallet after importing



## importwallet

```javascript
let file, rescan;
```

```shell--vars
file='/home/user/WalletDump'
rescan=false
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "importwallet",
    "params": [ "'$file'", '$rescan' ]
  }'
```

```shell--cli
hsw-cli rpc importwallet $file $rescan
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
  const result = await walletClient.execute('importwallet', [file, rescan]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Import all keys from a  wallet backup file. Also see [dumpwallet](#dumpwallet).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | file | Required | Path to wallet file
2 | rescan | Optional | (bool) Whether to rescan wallet after importing



## importaddress

```javascript
let address;
```

```shell--vars
address='rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "importaddress",
    "params": [ "'$address'" ]
  }'
```

```shell--cli
hsw-cli rpc importaddress $address

# P2SH example, imports script as address rs1qdph22fv5u38yqdpqza94n5gqfwnc5t9e9uhcl7rtnezn66t22fwswttnsx
hsw-cli rpc importaddress 76a9145e50fb5b7475ebe2f7276ed3f29662e5321d1d7288ac "this_is_ignored" true true
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
  const result = await walletClient.execute('importaddress', [address]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Import address to a watch-only wallet.
May also import a Handshake output script (in hex) as pay-to-script-hash (P2WSH) address.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Address to watch in wallet
2 | label | Optional | [Ignored but required if additional parameters are passed](#rpc-calls-wallet)
3 | rescan | Optional | (bool) Whether to rescan wallet after importing
4 | p2sh | Optional | (bool) Whether to generate P2SH address from given script



## importprunedfunds

```javascript
let rawtx, txoutproof;
```

```shell--vars
rawtx='01000000010000000000000000000000000000000000000000000000000000000000000000ffffffff1e510e6d696e65642062792062636f696e048e0e9256080000000000000000ffffffff0100f2052a010000001976a9145e50fb5b7475ebe2f7276ed3f29662e5321d1d7288ac00000000'
txoutproof='0000002006226e46111a0b59caaf126043eb5bbf28c34f3a5e332a1fc7b2b73cf188910f212c89a2cb9e356d5134af3903c241d74d165f484ca04066a88cc90cadb7cb36e749355bffff7f20040000000100000001212c89a2cb9e356d5134af3903c241d74d165f484ca04066a88cc90cadb7cb360101'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "importprunedfunds",
    "params": [ "'$rawtx'", "'$txoutproof'" ]
  }'
```

```shell--cli
hsw-cli rpc importprunedfunds $rawtx $txoutproof
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
  const result = await walletClient.execute('importprunedfunds', [rawtx, txoutproof]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Imports funds (without rescan) into pruned wallets.
Corresponding address or script must previously be included in wallet.
Does NOT check if imported coins are already spent, rescan may be required after
the point in time in which the specified transaciton was included in the blockchain.
See [gettxoutproof](#gettxoutproof) and [removeprunedfunds](#removeprunedfunds).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | rawtx | Required | Raw transaction in hex that funds an address already in the wallet
2 | txoutproof | Required | Hex output from [gettxoutproof](#gettxoutproof) containing the tx



## importpubkey

```javascript
let pubkey;
```

```shell--vars
pubkey='02548e0a23b90505f1b4017f52cf2beeaa399fce7ff2961e29570c6afdfa9bfc5b'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "importpubkey",
    "params": [ "'$pubkey'" ]
  }'
```

```shell--cli
hsw-cli rpc importpubkey $pubkey
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
  const result = await walletClient.execute('importpubkey', [pubkey]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Import public key to a watch-only wallet.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | pubkey | Required | Hex-encoded public key
2 | label | Optional | [Ignored but required if additional parameters are passed](#rpc-calls-wallet)
3 | rescan | Optional | (bool) Whether to rescan wallet after importing


## listaccounts

```javascript
let minconf, watchonly;
```

```shell--vars
minconf=6
watchonly=false
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "listaccounts",
    "params": [ '$minconf', '$watchonly' ]
  }'
```

```shell--cli
hsw-cli rpc listaccounts $minconf $watchonly
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
  const result = await walletClient.execute('listaccounts', [minconf, watchonly]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "default": 46.876028,
  "savings": 9.373432
}
```

Get list of account names and balances.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | minconf | Optional | Minimum confirmations for transaction to be included in balance
2 | watchonly | Optional | (bool) Include watch-only addresses



## listaddressgroupings

Not implemented.



## lockunspent

```javascript
let unlock, outputs;
outputs=[{ "txid": "3962a06342fc62a733700d74c075a5d24c4f44f7108f6d9a318b66e92e3bdc72", "vout": 1 }];
```

```shell--vars
unlock=false
```

```shell--curl
outputs='[{ "txid": "3962a06342fc62a733700d74c075a5d24c4f44f7108f6d9a318b66e92e3bdc72", "vout": 1 }]'

curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "lockunspent",
    "params": [ '$unlock', '"$outputs"' ]
  }'
```

```shell--cli
outputs='[{ "txid": "3962a06342fc62a733700d74c075a5d24c4f44f7108f6d9a318b66e92e3bdc72", "vout": 1 }]'

hsw-cli rpc lockunspent $unlock "$outputs"

# unlock all coins
hsw-cli rpc lockunspent true
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
  const result = await walletClient.execute('lockunspent', [unlock, outputs]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
true
```

Lock or unlock specified transaction outputs. If no outputs are specified,
ALL coins will be unlocked (`unlock` only).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | unlock | Required | (bool) `true` = unlock coins, `false` = lock coins
2 | outputs | Optional | Array of outputs to lock or unlock



## listlockunspent

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "listlockunspent" }'
```

```shell--cli
hsw-cli rpc listlockunspent
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
  const result = await walletClient.execute('listlockunspent');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  {
    "txid": "3962a06342fc62a733700d74c075a5d24c4f44f7108f6d9a318b66e92e3bdc72",
    "vout": 1
  }
]
```

Get list of currently locked (unspendable) outputs.
See [lockunspent](#lockunspent) and [lock-coin-outpoints](#lock-coin-outpoints).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## listreceivedbyaccount

```javascript
let minconf, includeEmpty, watchOnly;
```

```shell--vars
minconf=1
includeEmpty=true
watchOnly=true
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "listreceivedbyaccount",
    "params": [ '$minconf', '$includeEmpty', '$watchOnly' ]
  }'
```

```shell--cli
hsw-cli rpc listreceivedbyaccount $minconf $includeEmpty $watchOnly
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
  const result = await walletClient.execute('listreceivedbyaccount', [minconf, includeEmpty, watchOnly]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  {
    "involvesWatchonly": false,
    "account": "hot",
    "amount": 6.250004,
    "confirmations": 0,
    "label": ""
  },
  {
    "involvesWatchonly": false,
    "account": "default",
    "amount": 96.876528,
    "confirmations": 0,
    "label": ""
  },
  {
    "involvesWatchonly": false,
    "account": "savings",
    "amount": 9.373452,
    "confirmations": 0,
    "label": ""
  }
]
```

Get balances for all accounts in wallet.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | minconf | Optional | Minimum confirmations required to count a transaction
2 | includeEmpty | Optional | (bool) Whether to include accounts with zero balance
3 | watchOnly | Optional | (bool) Whether to include watch-only addresses



## listreceivedbyaddress

```javascript
let minconf, includeEmpty, watchOnly;
```

```shell--vars
minconf=1
includeEmpty=false
watchOnly=false
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "listreceivedbyaddress",
    "params": [ '$minconf', '$includeEmpty', '$watchOnly' ]
  }'
```

```shell--cli
hsw-cli rpc listreceivedbyaddress $minconf $includeEmpty $watchOnly 
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
  const result = await walletClient.execute('listreceivedbyaddress', [minconf, includeEmpty, watchOnly]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  {
    "involvesWatchonly": false,
    "address": "rs1qu76q03eh26j9c6zet63w859qu7eprdgkx29eu9",
    "account": "default",
    "amount": 2000,
    "confirmations": 260,
    "label": ""
  },
  {
    "involvesWatchonly": false,
    "address": "rs1qarnfdzqpuxmh224s9fqnf20msnwpa88av7hdvw",
    "account": "default",
    "amount": 2000.00022,
    "confirmations": 280,
    "label": ""
  },
  {
    "involvesWatchonly": false,
    "address": "rs1q7w7qm0cjtsxnkkssjxs05ud4jyfgwsgrundcw6",
    "account": "default",
    "amount": 280000.04264,
    "confirmations": 1361,
    "label": ""
  },
  ...
]
```

Get balances for all addresses in wallet.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | minconf | Optional | Minimum confirmations required to count a transaction
2 | includeEmpty | Optional | (bool) Whether to include addresses with zero balance
3 | watchOnly | Optional | (bool) Whether to include watch-only addresses



## listsinceblock

```javascript
let block, minconf, watchOnly;
```

```shell--vars
block='584aec6d0cbb033bbe0423ac9cff0249a0e0adc4d67dab79e244558175dd94d8'
minconf=1
watchOnly=false
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "listsinceblock",
    "params": [ "'$block'", '$minconf', '$watchOnly' ]
  }'
```

```shell--cli
hsw-cli rpc listsinceblock $block $minconf $watchOnly 
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
  const result = await walletClient.execute('listsinceblock', [block, minconf, watchOnly]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "transactions": [
    {
      "account": "default",
      "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl",
      "category": "receive",
      "amount": 2000,
      "label": "default",
      "vout": 0,
      "confirmations": 520,
      "blockhash": "26f5d8379fee2ac3a2434acf00e73bb0539d9af20ba6860bee430ad9e0df548f",
      "blockindex": -1,
      "blocktime": 1580929964,
      "blockheight": 1081,
      "txid": "ff09bd1a48a2682d157cb391b3a53ef5efcea50641d4199d12d62b438833f150",
      "walletconflicts": [],
      "time": 1580929833,
      "timereceived": 1580929833
    },
    {
      "account": "default",
      "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl",
      "category": "receive",
      "amount": 2000,
      "label": "default",
      "vout": 0,
      "confirmations": 537,
      "blockhash": "040a79d7a441e6c111153fc0c951b050b921ce2866b41845988afa5f387fe947",
      "blockindex": -1,
      "blocktime": 1580929961,
      "blockheight": 1064,
      "txid": "ff7daf0e76feddf1299fe948511b3247b7d9ff71157d4b8c9a3538e54384bac5",
      "walletconflicts": [],
      "time": 1580929833,
      "timereceived": 1580929833
    },
    {
      "account": "default",
      "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl",
      "category": "receive",
      "amount": 2000,
      "label": "default",
      "vout": 0,
      "confirmations": 481,
      "blockhash": "739342930f4216b8065a4e833d0d78170b6fb67c129036000dbb9a9d67dca865",
      "blockindex": -1,
      "blocktime": 1580929970,
      "blockheight": 1120,
      "txid": "fff4047ac27acb9bdf20128a4558b563eb9838ea328908d06194cbaf323f488e",
      "walletconflicts": [],
      "time": 1580929833,
      "timereceived": 1580929833
    }
  ],
  "lastblock": "584aec6d0cbb033bbe0423ac9cff0249a0e0adc4d67dab79e244558175dd94d8"
}
```

Get all transactions in blocks since a block specified by hash, or all
transactions if no block is specifiied.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | block | Optional | Hash of earliest block to start listing from
2 | minconf | Optional | Minimum confirmations required to count a transaction
3 | watchOnly | Optional | (bool) Whether to include watch-only addresses



## listtransactions

```javascript
let account, count, from, watchOnly;
```

```shell--vars
account='hot'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "listtransactions",
    "params": [ "'$account'" ]
  }'
```

```shell--cli
hsw-cli rpc listtransactions $account
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
  const result = await walletClient.execute('listtransactions', [account]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  {
    "account": "default",
    "address": "rs1q7w7qm0cjtsxnkkssjxs05ud4jyfgwsgrundcw6",
    "category": "receive",
    "amount": 2000,
    "label": "default",
    "vout": 0,
    "confirmations": 1497,
    "blockhash": "7295cec3fd81a2c2ddddf3faf6c000614b429ae0f8c1b2ef83ec937ac227d8e1",
    "blockindex": -1,
    "blocktime": 1580917307,
    "blockheight": 104,
    "txid": "adb098a6b38e7c4b2dd0af454f0c9537a3ec735a0b84c3d20b6f241768be12f2",
    "walletconflicts": [],
    "time": 1580917307,
    "timereceived": 1580917307
  },
  {
    "account": "default",
    "address": "rs1q7w7qm0cjtsxnkkssjxs05ud4jyfgwsgrundcw6",
    "category": "receive",
    "amount": 2000,
    "label": "default",
    "vout": 0,
    "confirmations": 1499,
    "blockhash": "0e7cc9e0dff3d0b3322cec63dad7160fc68a4e7ec3e7a32b5aa84418dfdb7d7c",
    "blockindex": -1,
    "blocktime": 1580917305,
    "blockheight": 102,
    "txid": "c256c4d550227f5ecd3d6f2af2e9d7005738f5b7b93c62f73746d68f067e9041",
    "walletconflicts": [],
    "time": 1580917307,
    "timereceived": 1580917307
  },
  {
    "account": "default",
    "address": "rs1q7w7qm0cjtsxnkkssjxs05ud4jyfgwsgrundcw6",
    "category": "receive",
    "amount": 2000,
    "label": "default",
    "vout": 0,
    "confirmations": 1492,
    "blockhash": "167fc99c384ee2ab6e2e3b0a32f4d0d979aaf99cc3b285fbf642f704a6a939c3",
    "blockindex": -1,
    "blocktime": 1580917308,
    "blockheight": 109,
    "txid": "cfef79516a5f0159ec95a49e5ec25295315dafcbbed408d2a13a0aec05005953",
    "walletconflicts": [],
    "time": 1580917307,
    "timereceived": 1580917307
  }
]
```

Get all recent transactions for specified account up to a limit, starting from
a specified index.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | account | Optional | Account name
2 | count | Optional | Max number of transactions to return
3 | from | Optional | Number of oldest transactions to skip
4 | watchOnly | Optional | Whether to include watch-only addresses



## listunspent

```javascript
let minconf, maxconf, addrs;
addrs=["rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl"];
```

```shell--vars
minconf=0
maxconf=20
```

```shell--curl
addrs='["rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl"]'


curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "listunspent",
    "params": [ '$minconf', '$maxconf', '"$addrs"' ]
  }'
```

```shell--cli
addrs='["rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl"]'

hsw-cli rpc listunspent $minconf $maxconf $addrs
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
  const result = await walletClient.execute('listunspent', [minconf, maxconf, addrs]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  {
    "txid": "7f57842a6d03adfe064590db2ab735e600a10e66d5942dac79cf451ddae83fc6",
    "vout": 0,
    "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl",
    "account": "default",
    "amount": 2000,
    "confirmations": 1,
    "spendable": true,
    "solvable": true
  }
]
```

Get unsepnt transaction outputs from all addreses, or a specific set
of addresses.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | minconf | Optional | Minimum confirmations required to return tx
2 | maxconf | Optional | Maximum confirmations required to return tx
3 | addrs | Optional | Array of addresses to filter


## sendfrom
<aside class="warning">
This command involves entering HNS values, be careful with <a href="#values">different formats</a> of values for different APIs.
</aside>

```javascript
let fromaccount, toaddress, amount;
```

```shell--vars
fromaccount='hot'
toaddress='rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3'
amount=0.0195
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "sendfrom",
    "params": [ "'$fromaccount'", "'$toaddress'", '$amount' ]
  }'
```

```shell--cli
hsw-cli rpc sendfrom $fromaccount $toaddress $amount
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
  const result = await walletClient.execute('sendfrom', [fromaccount, toaddress, amount]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
94f8a6dbaea9b5863d03d3b606c24e2e588d9e82564972148d54058660308e6a
```

Send HNS from an account to an address.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | fromaccount | Required | Wallet account to spend outputs from
2 | toaddress | Required | Handshake address to send funds to
3 | amount | Required | Amount (in HNS) to send
4 | minconf | Optional | Minimum confirmations for output to be spent from


## sendmany
<aside class="warning">
This command involves entering HNS values, be careful with <a href="#values">different formats</a> of values for different APIs.
</aside>

```javascript
let fromaccount, outputs, minconf, label, subtractFee;
outputs={"rs1qkk62444euknkya4qws9cg3ej3au24n635n4qye": 0.123, "rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3": 0.321}
```

```shell--vars
fromaccount='hot'
minconf=1
label="this_is_ignored"
subtractfee=false
```

```shell--curl
outputs='{"rs1qkk62444euknkya4qws9cg3ej3au24n635n4qye": 0.123, "rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3": 0.321}'

curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "sendmany",
    "params": [ "'$fromaccount'", '"$outputs"', '$minconf', "'$label'", '$subtractfee' ]
  }'
```

```shell--cli
outputs='{"rs1qkk62444euknkya4qws9cg3ej3au24n635n4qye": 0.123, "rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3": 0.321}'

hsw-cli rpc sendmany $fromaccount "$outputs" $minconf $label $subtractfee
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
  const result = await walletClient.execute('sendmany', [fromaccount, outputs, minconf, label, subtractfee]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
121d1e44f8125f02433e96c7b672a34af00be9906895f0ee51aaf504f4d76b78
```

Send different amounts of HNS from an account to multiple addresses. 

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | fromaccount | Required | Wallet account to spend outputs from
2 | outputs | Required | Array of Handshake addresses and amounts to send
3 | minconf | Optional | Minimum confirmations for output to be spent from
5 | label | Optional | [Ignored but required if additional parameters are passed](#rpc-calls-wallet)
6 | subtractfee | Optional | (bool) Subtract the transaction fee equally from the output amounts


## createsendtoaddress
<aside class="warning">
This command involves entering HNS values, be careful with <a href="#values">different formats</a> of values for different APIs.
</aside>

```javascript
let address, amount, comment, comment_to, subtractFee;
```

```shell--vars
address='rs1qkk62444euknkya4qws9cg3ej3au24n635n4qye'
amount=1.010101
comment="this_is_ignored"
comment_to="this_is_ignored"
subtractfee=true
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "createsendtoaddress",
    "params": [ "'$address'", '$amount', "'$comment'", "'$comment_to'", '$subtractfee' ]
  }'
```

```shell--cli
hsw-cli rpc createsendtoaddress $address $amount $comment $commnt_to $subtractfee
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
  const result = await walletClient.execute('createsendtoaddress', [address, amount, comment, comment_to, subtractfee]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
552006b288266ab26fa30d9048b758a469a4101fd8235eff2384141ca5cf604d
```

Create transaction sending HNS to a given address without signing or broadcasting it.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Handshake address to send funds to
2 | amount | Required | Amount (in HNS) to send
4 | comment | Optional | [Ignored but required if additional parameters are passed](#rpc-calls-wallet)
5 | comment_to | Optional | [Ignored but required if additional parameters are passed](#rpc-calls-wallet)
6 | subtractfee | Optional | (bool) Subtract the transaction fee equally from the output amount




## sendtoaddress
<aside class="warning">
This command involves entering HNS values, be careful with <a href="#values">different formats</a> of values for different APIs.
</aside>

```javascript
let address, amount, comment, comment_to, subtractFee;
```

```shell--vars
address='rs1qkk62444euknkya4qws9cg3ej3au24n635n4qye'
amount=1.010101
comment="this_is_ignored"
comment_to="this_is_ignored"
subtractfee=true
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "sendtoaddress",
    "params": [ "'$address'", '$amount', "'$comment'", "'$comment_to'", '$subtractfee' ]
  }'
```

```shell--cli
hsw-cli rpc sendtoaddress $address $amount $comment $commnt_to $subtractfee
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
  const result = await walletClient.execute('sendtoaddress', [address, amount, comment, comment_to, subtractfee]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
552006b288266ab26fa30d9048b758a469a4101fd8235eff2384141ca5cf604d
```

Send HNS to an address.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Handshake address to send funds to
2 | amount | Required | Amount (in HNS) to send
4 | comment | Optional | [Ignored but required if additional parameters are passed](#rpc-calls-wallet)
5 | comment_to | Optional | [Ignored but required if additional parameters are passed](#rpc-calls-wallet)
6 | subtractfee | Optional | (bool) Subtract the transaction fee equally from the output amount


## settxfee
<aside class="warning">
This command involves entering HNS values, be careful with <a href="#values">different formats</a> of values for different APIs.
</aside>

```javascript
let rate;
```

```shell--vars
rate=0.001
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "settxfee",
    "params": [ '$rate' ]
  }'
```

```shell--cli
hsw-cli rpc settxfee $rate
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
  const result = await walletClient.execute('settxfee', [rate]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
true
```

Set the fee rate for all new transactions until the fee is
changed again, or set to `0` (will return to automatic fee).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | rate | Required | Fee rate in HNS/kB



## signmessage

```javascript
let address, message;
```

```shell--vars
address='rs1qkk62444euknkya4qws9cg3ej3au24n635n4qye'
message='Satoshi'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "signmessage",
    "params": [ "'$address'", "'$message'" ]
  }'
```

```shell--cli
hsw-cli rpc signmessage $address $message
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
  const result = await walletClient.execute('signmessage', [address, message]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
MEUCIQC5Zzr+JoenWHy7m9XxpbDVVeg3DvKvJVQNyYPvLOuB2gIgP/BT3dRItxarNbE8ajEoTI66q3eB4lo+/SLsp7bbP70=
```

Sign an arbitrary message with the private key corresponding to a
specified Handshake address in the wallet.

<aside>Note: Due to behavior of some shells like bash, if your message contains spaces you may need to add additional quotes like this: <code>"'"$message"'"</code></aside>

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Wallet address to use for signing
2 | message | Required | The message to sign



## walletlock

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "walletlock" }'
```

```shell--cli
hsw-cli rpc walletlock
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
  const result = await walletClient.execute('walletlock');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Locks the wallet by removing the decryption key from memory.
See [walletpassphrase](#walletpassphrase).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## walletpassphrasechange

```javascript
let old, passphrase;
```

```shell--vars
old='OneTwoThreeFour'
passphrase='CorrectHorseBatteryStaple'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "walletpassphrasechange",
    "params": [ "'$old'", "'$passphrase'" ]
  }'
```

```shell--cli
hsw-cli rpc walletpassphrasechange $old $passphrase
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
  const result = await walletClient.execute('walletpassphrasechange', [old, passphrase]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Change the wallet encryption pasphrase

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | old | Required | The current wallet passphrase
2 | passphrase | Required | New passphrase



## walletpassphrase

```javascript
let passphrase, timeout;
```

```shell--vars
passphrase='CorrectHorseBatteryStaple'
timeout=600
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "walletpassphrase",
    "params": [ "'$passphrase'", '$timeout' ]
  }'
```

```shell--cli
hsw-cli rpc walletpassphrase $passphrase $timeout
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
  const result = await walletClient.execute('walletpassphrase', [passphrase, timeout]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Store wallet decryption key in memory, unlocking the wallet keys.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | passphrase | Required | The current wallet passphrase
2 | timeout | Required | Amount of time in seconds decryption key will stay in memory



## removeprunedfunds

```javascript
let txid;
```

```shell--vars
txid='6478cafe0c91e5ed4c55ade3b1726209caa0d290c8a3a84cc345caad60073ad5'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "removeprunedfunds",
    "params": [ "'$txid'" ]
  }'
```

```shell--cli
hsw-cli rpc removeprunedfunds $txid
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
  const result = await walletClient.execute('removeprunedfunds', [txid]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Deletes the specified transaction from the wallet database.
See [importprunedfunds](#importprunedfunds).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | txid | Required | txid of the transaction to remove



## wallet getmemoryinfo

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "getmemoryinfo" }'
```

```shell--cli
hsw-cli rpc getmemoryinfo
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
  const result = await walletClient.execute('getmemoryinfo');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "total": 133,
  "jsHeap": 17,
  "jsHeapTotal": 20,
  "nativeHeap": 112,
  "external": 30
}
```

Get information about memory usage.
Identical to node RPC call [getmemoryinfo](#getmemoryinfo).

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## wallet setloglevel

```javascript
let level;
```

```shell--vars
level='debug'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{
    "method": "setloglevel",
    "params": [ "'$level'" ]
  }'
```

```shell--cli
hsw-cli rpc setloglevel $level
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
  const result = await walletClient.execute('setloglevel', [level]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
null
```

Change Log level of the running node.

Levels are: `NONE`, `ERROR`, `WARNING`, `INFO`, `DEBUG`, `SPAM`


### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | level | Required | Level for the logger



## wallet stop

```shell--curl
curl http://x:api-key@127.0.0.1:14039 \
  -X POST \
  --data '{ "method": "stop" }'
```

```shell--cli
hsw-cli rpc stop
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
  const result = await walletClient.execute('stop');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```
"Stopping."
```

Closes the wallet database.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |

