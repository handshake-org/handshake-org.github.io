# Wallet - Auctions


## Get Wallet Names

```shell--vars
id='primary'
```

```shell--curl
curl $walleturl/$id/name
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getNames();
  console.log(result);
})();
```

> Sample response:

```json
[
  {
    "name": "handshake",
    "nameHash": "3aa2528576f96bd40fcff0bd6b60c44221d73c43b4e42d4b908ed20a93b8d1b6",
    "state": "BIDDING",
    "height": 245,
    "renewal": 245,
    "owner": {
      "hash": "0000000000000000000000000000000000000000000000000000000000000000",
      "index": 4294967295
    },
    "value": 0,
    "highest": 0,
    "data": "",
    "transfer": 0,
    "revoked": 0,
    "claimed": 0,
    "renewals": 0,
    "registered": false,
    "expired": false,
    "weak": false,
    "stats": {
      "bidPeriodStart": 251,
      "bidPeriodEnd": 256,
      "blocksUntilReveal": 2,
      "hoursUntilReveal": 0.33
    }
  }
]
```

List the states of all names known to the wallet.

### HTTP Request

`GET /wallet/:id/name`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id


## Get Wallet Name

```shell--vars
id='primary'
name='handshake'
```

```shell--curl
curl $walleturl/$id/name/$name
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getName(name);
  console.log(result);
})();
```

> Sample response:

```json
{
  "name": "handshake",
  "nameHash": "3aa2528576f96bd40fcff0bd6b60c44221d73c43b4e42d4b908ed20a93b8d1b6",
  "state": "BIDDING",
  "height": 245,
  "renewal": 245,
  "owner": {
    "hash": "0000000000000000000000000000000000000000000000000000000000000000",
    "index": 4294967295
  },
  "value": 0,
  "highest": 0,
  "data": "",
  "transfer": 0,
  "revoked": 0,
  "claimed": 0,
  "renewals": 0,
  "registered": false,
  "expired": false,
  "weak": false,
  "stats": {
    "bidPeriodStart": 251,
    "bidPeriodEnd": 256,
    "blocksUntilReveal": 2,
    "hoursUntilReveal": 0.33
  }
}
```

List the status of a single name known to the wallet.

### HTTP Request

`GET /wallet/:id/name/:name`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id
name <br> _string_ | name


## Get Wallet Auctions

```shell--vars
id='primary'
```

```shell--curl
curl $walleturl/$id/auction
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getAuctions();
  console.log(result);
})();
```

> Sample response:

```json
[
  {
    "name": "easyhandshake",
    "nameHash": "7550acc639a10fd7bb2e6e1d183f364127c3adfcb4d171d98b0319f973286324",
    "state": "CLOSED",
    "height": 105,
    "renewal": 135,
    "owner": {
      "hash": "b87a69556f924735876acb57c2ef46ff9c5a044ab61e5f0566ecc9357107a67e",
      "index": 0
    },
    "value": 0,
    "highest": 1000000,
    "data": "00060114737076206e6f646520696e2062726f7773657221",
    "transfer": 0,
    "revoked": 0,
    "claimed": 0,
    "renewals": 0,
    "registered": true,
    "expired": false,
    "weak": false,
    "stats": {
      "renewalPeriodStart": 135,
      "renewalPeriodEnd": 5135,
      "blocksUntilExpire": 4881,
      "daysUntilExpire": 33.9
    },
    "bids": [
      {
        "name": "easyhandshake",
        "nameHash": "7550acc639a10fd7bb2e6e1d183f364127c3adfcb4d171d98b0319f973286324",
        "prevout": {
          "hash": "0702d5f7cf4afd626189c1f8362676a5e7b7edfa5110d256a57185f32a3d12e1",
          "index": 0
        },
        "value": 1000000,
        "lockup": 2000000,
        "blind": "3d694cb7529caae741b6e70db09a0102c61813420b161cee65fb657e116d1f5b",
        "own": true
      }
    ],
    "reveals": [
      {
        "name": "easyhandshake",
        "nameHash": "7550acc639a10fd7bb2e6e1d183f364127c3adfcb4d171d98b0319f973286324",
        "prevout": {
          "hash": "10f18571b6b7af1f256ebe74d5da06d792da91ceb7f3f93302c0d216e1f899b8",
          "index": 0
        },
        "value": 1000000,
        "height": 125,
        "own": true
      }
    ]
  }
]
```

List the states of all auctions known to the wallet.

### HTTP Request

`GET /wallet/:id/auction`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id


## Get Wallet Auction by Name

```shell--vars
id='primary'
name='handshake'
```

```shell--curl
curl $walleturl/$id/auction/$name
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getAuctionByName(name);
  console.log(result);
})();
```

> Sample response:

```json
{
  "name": "handshake",
  "nameHash": "7550acc639a10fd7bb2e6e1d183f364127c3adfcb4d171d98b0319f973286324",
  "state": "CLOSED",
  "height": 105,
  "renewal": 135,
  "owner": {
    "hash": "b87a69556f924735876acb57c2ef46ff9c5a044ab61e5f0566ecc9357107a67e",
    "index": 0
  },
  "value": 0,
  "highest": 1000000,
  "data": "00060114737076206e6f646520696e2062726f7773657221",
  "transfer": 0,
  "revoked": 0,
  "claimed": 0,
  "renewals": 0,
  "registered": true,
  "expired": false,
  "weak": false,
  "stats": {
    "renewalPeriodStart": 135,
    "renewalPeriodEnd": 5135,
    "blocksUntilExpire": 4881,
    "daysUntilExpire": 33.9
  },
  "bids": [
    {
      "name": "handshake",
      "nameHash": "7550acc639a10fd7bb2e6e1d183f364127c3adfcb4d171d98b0319f973286324",
      "prevout": {
        "hash": "0702d5f7cf4afd626189c1f8362676a5e7b7edfa5110d256a57185f32a3d12e1",
        "index": 0
      },
      "value": 1000000,
      "lockup": 2000000,
      "blind": "3d694cb7529caae741b6e70db09a0102c61813420b161cee65fb657e116d1f5b",
      "own": true
    }
  ],
  "reveals": [
    {
      "name": "handshake",
      "nameHash": "7550acc639a10fd7bb2e6e1d183f364127c3adfcb4d171d98b0319f973286324",
      "prevout": {
        "hash": "10f18571b6b7af1f256ebe74d5da06d792da91ceb7f3f93302c0d216e1f899b8",
        "index": 0
      },
      "value": 1000000,
      "height": 125,
      "own": true
    }
  ]
}
```

List the states of all auctions known to the wallet.

### HTTP Request

`GET /wallet/:id/auction/:name`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id
name <br> _string_ | name


## Get Wallet Bids

```shell--vars
id='primary'
own=true
```

```shell--curl
curl $walleturl/$id/bid?own=$own
```

```shell--cli
> no CLI command available
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

const options = {own};

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getBids(options);
  console.log(result);
})();
```

> Sample response:

```json
[
  {
    "name": "easyhandshake",
    "nameHash": "7550acc639a10fd7bb2e6e1d183f364127c3adfcb4d171d98b0319f973286324",
    "prevout": {
      "hash": "0702d5f7cf4afd626189c1f8362676a5e7b7edfa5110d256a57185f32a3d12e1",
      "index": 0
    },
    "value": 1000000,
    "lockup": 2000000,
    "blind": "3d694cb7529caae741b6e70db09a0102c61813420b161cee65fb657e116d1f5b",
    "own": true
  }
]
```

List all bids for all names known to the wallet.

### HTTP Request

`GET /wallet/:id/bid`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id
own <br> _bool_ | whether to only show bids from this wallet


## Get Wallet Bids by Name

```shell--vars
id='primary'
name='handshake'
own=false
```

```shell--curl
curl $walleturl/$id/bid/$name?own=$own
```

```shell--cli
> no CLI command available
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

const options = {own};

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getBidsByName(name, options);
  console.log(result);
})();
```

> Sample response:

```json
[
  {
    "name": "handshake",
    "nameHash": "7550acc639a10fd7bb2e6e1d183f364127c3adfcb4d171d98b0319f973286324",
    "prevout": {
      "hash": "0702d5f7cf4afd626189c1f8362676a5e7b7edfa5110d256a57185f32a3d12e1",
      "index": 0
    },
    "value": 1000000,
    "lockup": 2000000,
    "blind": "3d694cb7529caae741b6e70db09a0102c61813420b161cee65fb657e116d1f5b",
    "own": true
  },
  {
    "name": "handshake",
    "nameHash": "3aa2528576f96bd40fcff0bd6b60c44221d73c43b4e42d4b908ed20a93b8d1b6",
    "prevout": {
      "hash": "b8ba9dfc78bdf0f0b1bf67abb9244af0b73c58a9c5bb79b98b72d14cf98c5c08",
      "index": 0
    },
    "lockup": 20000000,
    "blind": "47e8cf3dacfe6aeb14187ebd52f25c55c6f63fd24fed666c676c8ada0b132c10",
    "own": false
  }
]
```

List the bids for a specific name known to the wallet.

### HTTP Request

`GET /wallet/:id/bid/:name`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id
name <br> _string_ | name
own <br> _bool_ | whether to only show bids from this wallet


## Get Wallet Reveals

```shell--vars
id='primary'
own=false
```

```shell--curl
curl $walleturl/$id/reveal?own=$own
```

```shell--cli
> no CLI command available
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

const options = {own};

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getReveals(options);
  console.log(result);
})();
```

> Sample response:

```json
[
  {
    "name": "handshake",
    "nameHash": "3aa2528576f96bd40fcff0bd6b60c44221d73c43b4e42d4b908ed20a93b8d1b6",
    "prevout": {
      "hash": "6b90495db28d71bc96ad6211d87b78ab6a3b548b702a98f3149e41c3a0892140",
      "index": 0
    },
    "value": 1000000,
    "height": 221,
    "own": true
  },
  {
    "name": "handshake",
    "nameHash": "3aa2528576f96bd40fcff0bd6b60c44221d73c43b4e42d4b908ed20a93b8d1b6",
    "prevout": {
      "hash": "d8acd574cba75c32f5e671fad2adf7cc93854303be02212fe8628a727229d610",
      "index": 0
    },
    "value": 10000000,
    "height": 221,
    "own": false
  }
]
```

List all reveals for all names known to the wallet.

### HTTP Request

`GET /wallet/:id/reveal`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id
own <br> _bool_ |  whether to only show reveals from this wallet


## Get Wallet Reveals by Name

```shell--vars
id='primary'
name='handshake'
own=false
```

```shell--curl
curl $walleturl/$id/reveal/$name?own=$own
```

```shell--cli
> no CLI command available
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

const options = {own};

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getRevealsByName(name, options);
  console.log(result);
})();
```

> Sample response:

```json
[
  {
    "name": "handshake",
    "nameHash": "3aa2528576f96bd40fcff0bd6b60c44221d73c43b4e42d4b908ed20a93b8d1b6",
    "prevout": {
      "hash": "6b90495db28d71bc96ad6211d87b78ab6a3b548b702a98f3149e41c3a0892140",
      "index": 0
    },
    "value": 1000000,
    "height": 221,
    "own": true
  },
  {
    "name": "handshake",
    "nameHash": "3aa2528576f96bd40fcff0bd6b60c44221d73c43b4e42d4b908ed20a93b8d1b6",
    "prevout": {
      "hash": "d8acd574cba75c32f5e671fad2adf7cc93854303be02212fe8628a727229d610",
      "index": 0
    },
    "value": 10000000,
    "height": 221,
    "own": false
  }
]
```

List the reveals for a specific name known to the wallet.

### HTTP Request

`GET /wallet/:id/reveal/:name`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id
name <br> _string_ | name
own <br> _bool_ | whether to only show reveals from this wallet


## Get Wallet Resource by Name

```shell--vars
id='primary'
name='handshake'
```

```shell--curl
curl $walleturl/$id/resource/$name
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getResource(name);
  console.log(result);
})();
```

> Sample response:

```json
{
  "records": [
    {
      "type": "TXT",
      "txt": [
        "A decentralized DNS root zone!"
      ]
    }
  ]
}
```

Get the data resource associated with a name.

### HTTP Request

`GET /wallet/:id/resource`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id
name <br> _string_ | name


## Get Nonce for Bid

```shell--vars
id='primary'
name='handshake'
bid=2000000
address='rs1q3qavv25ye6zsntszsj4awvq7gr4akq59k9y8hw'
```

```shell--curl
curl "$walleturl/$id/nonce/$name?address=$address&bid=$bid"
```

```shell--cli
> no CLI command available
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

const options = {address, bid};

const walletClient = new WalletClient(walletOptions);
const wallet = walletClient.wallet(id);

(async () => {
  const result = await wallet.getNonce(name, options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "address": "rs1q3qavv25ye6zsntszsj4awvq7gr4akq59k9y8hw",
  "blind": "4c20a52be340636137e703db9031e0d3ab0fbc503c5b97463a814665595ed71f",
  "nonce": "69bbe132244d91b9fd13019f372e7dc79e487c44b126a226b39c8c287c15aff5",
  "bid": 1,
  "name": "handshake",
  "nameHash": "3aa2528576f96bd40fcff0bd6b60c44221d73c43b4e42d4b908ed20a93b8d1b6"
}
```

Deterministically generate a nonce to blind a bid.

Note that since multiple parameters are expected in the URL and therefore a `&`
must be used, the URL is wrapped in double-quotes to prevent the shell from
starting the process in the background.

### HTTP Request

`GET /wallet/:id/nonce/:name`


Parameters | Description
---------- | -----------
id <br> _string_ | wallet id
name <br> _string_ | name
bid <br> _float_ | value of bid to blind
address <br> _string_ | address controlling bid


## Send OPEN

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
```

```shell--curl
curl $walleturl/$id/open \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign'
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast, sign};

(async () => {
  const result = await wallet.createOpen(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "6901ec5576eb618e012058e62b34a0883c3832e1324ac9942bb5852e8a2e4a1f",
  "witnessHash": "2391068a2a3082468e77934973bdb9f18fab33437074428946d78443a2519d84",
  "mtime": 1580940345,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "a94415c789656239cf7fe2f642215c2d51814f09dad5486058bbb09a0be2084f",
        "index": 1
      },
      "witness": [
        "87ac7546878c9cbd4258d024698020d37b642150fec20c8950a1e26cfa06f0e70d4c882f2de05129c6c1c601ae5a89bd6874bea03dfeca8e89435b0fc44f151e01",
        "03c66829e94b4644a3d5481e192af62e5b0e0eb91cd78d45594c9c59e1a5b16360"
      ],
      "sequence": 4294967295,
      "address": "rs1q9k8ktktnrfsr8p677gfxgkf5g45x7vzez7egqv"
    }
  ],
  "outputs": [
    {
      "value": 0,
      "address": "rs1qx2wrlhtwg0exsa4sm3u7d7pz7ah3yld374jwd5",
      "covenant": {
        "type": 2,
        "action": "OPEN",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "00000000",
          "6272656164"
        ]
      }
    },
    {
      "value": 2000010260,
      "address": "rs1q30pw3zmgkktlr58fsycyuta3szgz0ldwnrg2wf",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000001a94415c789656239cf7fe2f642215c2d51814f09dad5486058bbb09a0be2084f01000000ffffffff0200000000000000000014329c3fdd6e43f26876b0dc79e6f822f76f127db1020320e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a040000000005627265616414bc35770000000000148bc2e88b68b597f1d0e981304e2fb1809027fdae000000000000024187ac7546878c9cbd4258d024698020d37b642150fec20c8950a1e26cfa06f0e70d4c882f2de05129c6c1c601ae5a89bd6874bea03dfeca8e89435b0fc44f151e012103c66829e94b4644a3d5481e192af62e5b0e0eb91cd78d45594c9c59e1a5b16360"
}
```

Create, sign, and send a name OPEN.

### HTTP Request

`POST /wallet/:id/open`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name to OPEN
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)


## Send BID

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
bid=1234000
lockup=4567000
```

```shell--curl
curl $walleturl/$id/bid \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign',
    "bid":'$bid',
    "lockup":'$lockup'
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast, sign, bid, lockup};

(async () => {
  const result = await wallet.createBid(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "5f86ba9b968a872b079947314c789735c2ad52eefc54e726d7e9e6b7fdf9a566",
  "witnessHash": "9e39c91a3dd9c0eaa352ed277d42f4f53920c4f89dce671389c0683586b70c2f",
  "mtime": 1580940435,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "d69f3282a74ef79755a22e01fed308ebad77bf62a3a55434d22761a010ffb04f",
        "index": 1
      },
      "witness": [
        "872456ed9c7da4105840b626690a793be881506866b2dca894b1a165dd528cc608cd03eee1cd46c3ce61accfa2da0cf31bfa3734f54ef693aaa8e480dc25277501",
        "03c25f5b28395ef101a38da38094e29bf57c3c618ffaef4e1c2a532efca9798722"
      ],
      "sequence": 4294967295,
      "address": "rs1qgw8df4vh4wg9w0le3xe7dv4ypq75h5fa0qst5v"
    }
  ],
  "outputs": [
    {
      "value": 4567000,
      "address": "rs1qrx9matjmly5l6cnz4ed7ujxcy9tf4cfcl0szeg",
      "covenant": {
        "type": 3,
        "action": "BID",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000",
          "6272656164",
          "135333369e5d91671cafe97904663692546d10b8ded8cd7662480074fd2f1ab0"
        ]
      }
    },
    {
      "value": 1995440140,
      "address": "rs1qn4r8xq7pfyhmf0z2rja38kgrpmavdufd03jfn5",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000001d69f3282a74ef79755a22e01fed308ebad77bf62a3a55434d22761a010ffb04f01000000ffffffff02d8af4500000000000014198bbeae5bf929fd6262ae5bee48d821569ae138030420e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e304000005627265616420135333369e5d91671cafe97904663692546d10b8ded8cd7662480074fd2f1ab00c00f0760000000000149d467303c1492fb4bc4a1cbb13d9030efac6f12d0000000000000241872456ed9c7da4105840b626690a793be881506866b2dca894b1a165dd528cc608cd03eee1cd46c3ce61accfa2da0cf31bfa3734f54ef693aaa8e480dc252775012103c25f5b28395ef101a38da38094e29bf57c3c618ffaef4e1c2a532efca9798722"
}
```

Create, sign, and send a name BID.

### HTTP Request

`POST /wallet/:id/bid`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name to BID on
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)
bid <br> _int_ | value (in dollarydoos) to bid for name
lockup <br> _int_ | value (in dollarydoos) to actually send in the transaction,<br>blinding the actual bid value


## Send REVEAL

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
```

```shell--curl
curl $walleturl/$id/reveal \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign'
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast, sign};

(async () => {
  const result = await wallet.createReveal(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "f2a58686813a66621f8a814c9cabf59a76342914ff56a0f44260a44ce095eadd",
  "height": -1,
  "block": null,
  "time": 0,
  "mtime": 1580941108,
  "date": "1970-01-01T00:00:00Z",
  "mdate": "2020-02-05T22:18:28Z",
  "size": 530,
  "virtualSize": 379,
  "fee": 7600,
  "rate": 20052,
  "confirmations": 0,
  "inputs": [
    {
      "value": 4567000,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3",
      "path": {
        "name": "default",
        "account": 0,
        "change": false,
        "derivation": "m/0'/0/10"
      }
    }
  ],
  "outputs": [
    {
      "value": 1234000,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3",
      "covenant": {
        "type": 4,
        "action": "REVEAL",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000",
          "5254fd6ae23148c8efbb4cb013c8d1c1048e412165632861f47535060c174736"
        ]
      },
      "path": {
        "name": "default",
        "account": 0,
        "change": false,
        "derivation": "m/0'/0/10"
      }
    },
    {
      "value": 6658400,
      "address": "rs1qmchpnu3ktztqhlkk9ydkehd6qldemd9prvgvrp",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      },
      "path": {
        "name": "default",
        "account": 0,
        "change": true,
        "derivation": "m/0'/1/10"
      }
    }
  ],
  "tx": "00000000021d9b7b7d829fa307f602d0c4057a6d733ccfca06c622ecf2456149c5c3da915600000000ffffffff5f86ba9b968a872b079947314c789735c2ad52eefc54e726d7e9e6b7fdf9a56600000000ffffffff0350d412000000000000141b8f66a6b3cdc3ddd5502dfdaf007cc2038c7004040320e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e3040000205254fd6ae23148c8efbb4cb013c8d1c1048e412165632861f47535060c17473650d41200000000000014198bbeae5bf929fd6262ae5bee48d821569ae138040320e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e304000020707bc55fdeb283cdc2114d3de30ed8bf7d4946eb589cf2239160566fb3683d8a60996500000000000014de2e19f23658960bfed6291b6cddba07db9db4a10000000000000241867a6e0d151fdc689eae00932b101af381ef99a19fc3535e740e6f3baca63b5b45db61413c7130b45ef546beda84f46f8adda8944d6dbae251c82062e17333da0121031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88024181532acdd7b591eed4e62c6123d14cfefbb11723c855728d3012286210536bb4192a58622dbd66cd3d876f14a906d2a04d1053247340b9985c2f0fa2c85004a7012102fcd5c0914405f04b12c5936c50642fb2cb10a6262dd2dd8ca243e26cbc984ead"
}
```

Create, sign, and send a name REVEAL. If multiple bids were placed on a name,
all bids will be revealed by this transaction. If no value is passed in for `name`,
all reveals for all names in the wallet will be sent.

### HTTP Request

`POST /wallet/:id/reveal`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name to REVEAL bids for (or `null` for all names)
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)


## Send REDEEM

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
```

```shell--curl
curl $walleturl/$id/redeem \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign'
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast, sign};

(async () => {
  const result = await wallet.createRedeem(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "9cc3c9f665ad79563667f74864bcfdfe280f9f3a2df4ee02d427b8dea34fe388",
  "height": -1,
  "block": null,
  "time": 0,
  "mtime": 1580942277,
  "date": "1970-01-01T00:00:00Z",
  "mdate": "2020-02-05T22:37:57Z",
  "size": 394,
  "virtualSize": 243,
  "fee": 4880,
  "rate": 20082,
  "confirmations": 0,
  "inputs": [
    {
      "value": 1234000,
      "address": "rs1qrx9matjmly5l6cnz4ed7ujxcy9tf4cfcl0szeg",
      "path": {
        "name": "default",
        "account": 0,
        "change": false,
        "derivation": "m/0'/0/9"
      }
    },
    {
      "value": 2000010260,
      "address": "rs1q30pw3zmgkktlr58fsycyuta3szgz0ldwnrg2wf",
      "path": {
        "name": "default",
        "account": 0,
        "change": true,
        "derivation": "m/0'/1/7"
      }
    }
  ],
  "outputs": [
    {
      "value": 1234000,
      "address": "rs1qrx9matjmly5l6cnz4ed7ujxcy9tf4cfcl0szeg",
      "covenant": {
        "type": 5,
        "action": "REDEEM",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000"
        ]
      },
      "path": {
        "name": "default",
        "account": 0,
        "change": false,
        "derivation": "m/0'/0/9"
      }
    },
    {
      "value": 2000005380,
      "address": "rs1qtw3nhk8t5waujzwm5vh4ylkp0ytjamnx0efu8s",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      },
      "path": {
        "name": "default",
        "account": 0,
        "change": true,
        "derivation": "m/0'/1/11"
      }
    }
  ],
  "tx": "0000000002f2a58686813a66621f8a814c9cabf59a76342914ff56a0f44260a44ce095eadd01000000ffffffff6901ec5576eb618e012058e62b34a0883c3832e1324ac9942bb5852e8a2e4a1f01000000ffffffff0250d41200000000000014198bbeae5bf929fd6262ae5bee48d821569ae138050220e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e304000004a935770000000000145ba33bd8eba3bbc909dba32f527ec179172eee660000000000000241bd37183812b9ae232e2b1400eea3b36afa420c8eb1c2a7c54402f88b61fb2680733da29697a0713bf7a3cc2f5176ed2d6f957fa8988d6c952d32443cf49a8ce9012102fcd5c0914405f04b12c5936c50642fb2cb10a6262dd2dd8ca243e26cbc984ead0241a33f7b362d9c0fb94c75c37d795ab6ab6e2566288cb278a1cb275d35f9e454f351c805c2c74cc9ff278694169a8b818d41d04488daf534f4223a803fc13eac0e012102b87379bf21a7a8b19edcbd4826406e7880e7f6352bd9068de57c8f7d7d2a7703"
}
```

Create, sign, and send a REDEEM. This transaction sweeps the value from losing
bids back into the wallet. If multiple bids (and reveals) were placed on a name,
all losing bids will be redeemed by this transaction. If no value is passed in for `name`,
all qualifying bids are redeemed.

### HTTP Request

`POST /wallet/:id/redeem`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name to REDEEM bids for (or `null` for all names)
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)


## Send UPDATE

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
type='TXT'
key='txt'
value='Bread is a delicious food.'
```

```shell--curl
curl $walleturl/$id/update \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign',
    "data": {"records": [ {"type": "'$type'", "'$key'": ["'"$value"'"]} ]}
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const data = {records: []};
const record = {type};
record[key] = [value];
data.records.push(record);

const options = {passphrase, name, broadcast, sign, data};

(async () => {
  const result = await wallet.createUpdate(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "31da65987a9b1573e4d051a07ec9e3d3845c649cba64c5789566369ba6ac9cbc",
  "witnessHash": "87d283aa0a863ca3f0d913f4b11281d8315e166c73a5cb46c19f94d721aefc43",
  "mtime": 1580943569,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "f2a58686813a66621f8a814c9cabf59a76342914ff56a0f44260a44ce095eadd",
        "index": 0
      },
      "witness": [
        "aab532bcd307bea84d7abb7926f598a9d63ac503cac8e416c7683ef71032e932133735464a92f7dc1f697a9a40b0f4cb13c4a5db0114b6a961de0cf924dac2a401",
        "031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88"
      ],
      "sequence": 4294967295,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3"
    },
    {
      "prevout": {
        "hash": "ed85504acb5e5005fe07567d17a5d2bd8c30a235ad15eb114f64e75fff172bbb",
        "index": 0
      },
      "witness": [
        "7948b87e5e42a4276bfbc548b0a23e3a01388a6158bfd872fc413fb1a8313ca023dcdcd6f28e2d97b542fe28c303dc2f861b1d4c8e41b5d99973e02a22ff1fc701",
        "02737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
      ],
      "sequence": 4294967295,
      "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl"
    }
  ],
  "outputs": [
    {
      "value": 1234000,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3",
      "covenant": {
        "type": 6,
        "action": "REGISTER",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000",
          "0006011a427265616420697320612064656c6963696f757320666f6f642e",
          "71e4ac7bd9a9eebe6aaaa99e8e08d10c8f2c184774feb844b6a180f8f7bba7ae"
        ]
      }
    },
    {
      "value": 2000002520,
      "address": "rs1qzgvngp7jtluup39rc2atfp6q3g2vuklj6qfrtq",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000002f2a58686813a66621f8a814c9cabf59a76342914ff56a0f44260a44ce095eadd00000000ffffffffed85504acb5e5005fe07567d17a5d2bd8c30a235ad15eb114f64e75fff172bbb00000000ffffffff0250d412000000000000141b8f66a6b3cdc3ddd5502dfdaf007cc2038c7004060420e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e30400001e0006011a427265616420697320612064656c6963696f757320666f6f642e2071e4ac7bd9a9eebe6aaaa99e8e08d10c8f2c184774feb844b6a180f8f7bba7aed89d357700000000001412193407d25ff9c0c4a3c2bab487408a14ce5bf20000000000000241aab532bcd307bea84d7abb7926f598a9d63ac503cac8e416c7683ef71032e932133735464a92f7dc1f697a9a40b0f4cb13c4a5db0114b6a961de0cf924dac2a40121031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c8802417948b87e5e42a4276bfbc548b0a23e3a01388a6158bfd872fc413fb1a8313ca023dcdcd6f28e2d97b542fe28c303dc2f861b1d4c8e41b5d99973e02a22ff1fc7012102737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
}
```

Create, sign, and send an UPDATE. This transaction updates the resource data
associated with a given name.

<aside>Note: Due to behavior of some shells like bash, if your TXT value contains spaces you may need to add additional quotes like this: <code>"'"$value"'"</code></aside>

### HTTP Request

`POST /wallet/:id/update`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name to REDEEM bids for (or `null` for all names)
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)
data <br> _object_ | JSON object containing an array of DNS records (see next section)


## Resource Object

The resource object must contain one property `records`, which is an array
of record objects. Each record object must have a property `type` which defines the DNS
record type. Depending on the type, the record object may have various additional properties.


```
// Example of a valid resource object
// containing examples of all available record types:

{
  records: [
    {
      type: 'DS',
      keyTag: 57355,
      algorithm: 8, // RSASHA256
      digestType: 2, // SHA256
      digest:
        '95a57c3bab7849dbcddf7c72ada71a88146b141110318ca5be672057e865c3e2'
    },
    {
      type: 'NS',
      ns: 'ns1.hns.'
    },
    {
      type: 'GLUE4',
      ns: 'ns2.hns.',
      address: '127.0.0.1'
    },
    {
      type: 'GLUE6',
      ns: 'ns2.hns.',
      address: '::1'
    },
    {
      type: 'SYNTH4',
      address: '127.0.0.2'
    },
    {
      type: 'SYNTH6',
      address: '::2'
    },
    {
      type: 'TXT',
      txt: ['hello world']
    }
  ]
}
```


## Send RENEW

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
```

```shell--curl
curl $walleturl/$id/renewal \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign'
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast};

(async () => {
  const result = await wallet.createRenewal(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "1e198eea5803646f58ccc74f2cd5a69942907f18d1c4fa6d5069920eda1634a4",
  "witnessHash": "78ca00baa443912e03aa5b32fa59b03b80e34d1aff94602b211b9fa58e03e4d2",
  "mtime": 1580995594,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "78ff6f7d974006bb6ab02631b09bd4896a3ebf000d23696562e7f07445ac7c0e",
        "index": 0
      },
      "witness": [
        "b599baa320a7118e600a26d26a1c89dcb8742b22a31953e57c1452914ccbdda23d727e894b4abfb250f1826f4e5c0393176c55cc521ffeae0b02477e84fbd58601",
        "031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88"
      ],
      "sequence": 4294967295,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3"
    },
    {
      "prevout": {
        "hash": "9cc3c9f665ad79563667f74864bcfdfe280f9f3a2df4ee02d427b8dea34fe388",
        "index": 1
      },
      "witness": [
        "8404a9d05c8baeb00a98f43b3aa332cc2be733ec53f226e2778f685b3b99b4f723877957e9db731ff86c2c0efe49edd85ba8c299e17005079612a0c4d6319f9901",
        "02f231291526e240e57ee2552cea5b8f7ac78f49cabbadb859930f9c4fb4316009"
      ],
      "sequence": 4294967295,
      "address": "rs1qtw3nhk8t5waujzwm5vh4ylkp0ytjamnx0efu8s"
    }
  ],
  "outputs": [
    {
      "value": 1234000,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3",
      "covenant": {
        "type": 8,
        "action": "RENEW",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000",
          "31008b4f5f79c4fa4de0766d9c5be5a49e0b39e18dc5a8701325e4b66611e07c"
        ]
      }
    },
    {
      "value": 1999999840,
      "address": "rs1qfepqfvsshhlq0555lsxvu6xetzydzaxxs6cvhe",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "000000000278ff6f7d974006bb6ab02631b09bd4896a3ebf000d23696562e7f07445ac7c0e00000000ffffffff9cc3c9f665ad79563667f74864bcfdfe280f9f3a2df4ee02d427b8dea34fe38801000000ffffffff0250d412000000000000141b8f66a6b3cdc3ddd5502dfdaf007cc2038c7004080320e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e30400002031008b4f5f79c4fa4de0766d9c5be5a49e0b39e18dc5a8701325e4b66611e07c609335770000000000144e4204b210bdfe07d294fc0cce68d95888d174c60000000000000241b599baa320a7118e600a26d26a1c89dcb8742b22a31953e57c1452914ccbdda23d727e894b4abfb250f1826f4e5c0393176c55cc521ffeae0b02477e84fbd5860121031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c8802418404a9d05c8baeb00a98f43b3aa332cc2be733ec53f226e2778f685b3b99b4f723877957e9db731ff86c2c0efe49edd85ba8c299e17005079612a0c4d6319f99012102f231291526e240e57ee2552cea5b8f7ac78f49cabbadb859930f9c4fb4316009"
}
```

Create, sign, and send a RENEW.

### HTTP Request

`POST /wallet/:id/renew`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name to RENEW
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)


## Send TRANSFER

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
address='rs1qe4tnr7zhx95uvfw220k7eh9ke0rtducpp3hgjc'
```

```shell--curl
curl $walleturl/$id/transfer \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign',
    "address":"'$address'"
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast, address};

(async () => {
  const result = await wallet.createTransfer(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "b5d3c0caaa14913c15cf219095c23feb0b6b7fa2327428d377da2bb21044045e",
  "witnessHash": "6d88b3910c047ca69d0a8a833ba17888dc31f8111d5da59e9db5978499607e6e",
  "mtime": 1580995968,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "0b90f30f05e1073e5a34426eea244e66eaa0878b3d065b45cad9a5247dd36425",
        "index": 0
      },
      "witness": [
        "ea9ca5c0d619fa548f51384c443d01e34099ba2d590a2f5b9b334d35d1c1fc3e6e739b4f9a9c415c43cd70aa567d4cd820a7a91d0f76164838a9e0967ffdabad01",
        "031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88"
      ],
      "sequence": 4294967295,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3"
    },
    {
      "prevout": {
        "hash": "29d8311eebb36fcb64cc2c5094120ba966feb494b277763abdba0d6766668166",
        "index": 0
      },
      "witness": [
        "57c79c840a1a62f74129a18da6d648999c61c2a270a660851815d5bc48729380612a08d7a8a3f7608f351a2a7a0dfa858cd2f951f6868b902617dd2d61ba8e9801",
        "02737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
      ],
      "sequence": 4294967295,
      "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl"
    }
  ],
  "outputs": [
    {
      "value": 1234000,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3",
      "covenant": {
        "type": 9,
        "action": "TRANSFER",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000",
          "00",
          "cd5731f8573169c625ca53edecdcb6cbc6b6f301"
        ]
      }
    },
    {
      "value": 2000000200,
      "address": "rs1q5w4jvv9rkv3w2tdvegzmdv3a7gzucefc45xqsw",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "00000000020b90f30f05e1073e5a34426eea244e66eaa0878b3d065b45cad9a5247dd3642500000000ffffffff29d8311eebb36fcb64cc2c5094120ba966feb494b277763abdba0d676666816600000000ffffffff0250d412000000000000141b8f66a6b3cdc3ddd5502dfdaf007cc2038c7004090420e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e3040000010014cd5731f8573169c625ca53edecdcb6cbc6b6f301c8943577000000000014a3ab2630a3b322e52dacca05b6b23df205cc65380000000000000241ea9ca5c0d619fa548f51384c443d01e34099ba2d590a2f5b9b334d35d1c1fc3e6e739b4f9a9c415c43cd70aa567d4cd820a7a91d0f76164838a9e0967ffdabad0121031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88024157c79c840a1a62f74129a18da6d648999c61c2a270a660851815d5bc48729380612a08d7a8a3f7608f351a2a7a0dfa858cd2f951f6868b902617dd2d61ba8e98012102737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
}
```

Create, sign, and send a TRANSFER.

### HTTP Request

`POST /wallet/:id/transfer`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name to TRANSFER
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)
address <br> _string_  | address to transfer name ownership to


## Cancel TRANSFER

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
```

```shell--curl
curl $walleturl/$id/cancel \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign'
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast};

(async () => {
  const result = await wallet.createCancel(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "c67f89be56413deef37c07a38450e3bb0098f179abc30281bb55e5656039a64e",
  "witnessHash": "b4feded954a6371bb6e7e6699f842643e2387403612ebe1690c54d25e89532ec",
  "mtime": 1580996955,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "b5d3c0caaa14913c15cf219095c23feb0b6b7fa2327428d377da2bb21044045e",
        "index": 0
      },
      "witness": [
        "59698c78326150a7ba75e769d6c127ade0849127d89730c48c50d44684f4553a43f938b5dc70ee275f9d9290ef6225468c0ab5fb0bcb6609257cec0c0053bbcb01",
        "031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88"
      ],
      "sequence": 4294967295,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3"
    },
    {
      "prevout": {
        "hash": "76eb16e8b65826f0d411c3b78a5c2c349fde4d363b9818232eb0be48e3d108c3",
        "index": 0
      },
      "witness": [
        "51f2b83295fafbbdaf2b239cf347dae2182f318b8ddef6e075497cd9e50a486d465ddd934acd7630d93568db0602014bc6304f0f62bc9f51e293d9cf0b4cea4601",
        "02737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
      ],
      "sequence": 4294967295,
      "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl"
    }
  ],
  "outputs": [
    {
      "value": 1234000,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3",
      "covenant": {
        "type": 7,
        "action": "UPDATE",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000",
          ""
        ]
      }
    },
    {
      "value": 2000000440,
      "address": "rs1qp7ru55hjw96llagrhcjvznurra4tw60ucg409y",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000002b5d3c0caaa14913c15cf219095c23feb0b6b7fa2327428d377da2bb21044045e00000000ffffffff76eb16e8b65826f0d411c3b78a5c2c349fde4d363b9818232eb0be48e3d108c300000000ffffffff0250d412000000000000141b8f66a6b3cdc3ddd5502dfdaf007cc2038c7004070320e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e304000000b89535770000000000140f87ca52f27175fff503be24c14f831f6ab769fc000000000000024159698c78326150a7ba75e769d6c127ade0849127d89730c48c50d44684f4553a43f938b5dc70ee275f9d9290ef6225468c0ab5fb0bcb6609257cec0c0053bbcb0121031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88024151f2b83295fafbbdaf2b239cf347dae2182f318b8ddef6e075497cd9e50a486d465ddd934acd7630d93568db0602014bc6304f0f62bc9f51e293d9cf0b4cea46012102737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
}
```

Create, sign, and send a transaction that cancels a TRANSFER.

This transaction is not a unique covenant type, but spends from a TRANSFER to an
UPDATE covenant (with an empty resource object) in order to cancel a transfer
already in progress.

### HTTP Request

`POST /wallet/:id/cancel`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name in transferred state to cancel transfer for
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)


## Send FINALIZE

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
```

```shell--curl
curl $walleturl/$id/finalize \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign'
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast};

(async () => {
  const result = await wallet.createFinalize(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "164e610fc166fc26ac426c54924fc0b6b25e74523f57bec3f064f23b36e3e4c9",
  "witnessHash": "df5c9c4a7f4f1f02df1d28ab5a6040bdb13161bb674f14eeaa790080e265fb92",
  "mtime": 1580997210,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "3f650357a4de12f4d6b764f13ccfd473ab56d4390b6afb71941a429dc4b8cfc4",
        "index": 0
      },
      "witness": [
        "183b5de76722cf361c3cb1b509f537b9fafdab25d724e1d8f37db75c77684496208cbaca9ac59362ab70ef16d483f7371a28a231272c8e481f1af99fe931e48a01",
        "031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88"
      ],
      "sequence": 4294967295,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3"
    },
    {
      "prevout": {
        "hash": "de7a5680851d3b3bb4509d2559ebd1d61f61e0ca6eaae82225c4c5c4b8e89d1a",
        "index": 0
      },
      "witness": [
        "db8152812f0b5db8c94663020019806c6b441a0ff8d5ab9c01a1aca2ac4a98a70a90a6fff5ccda93fe80c39a6dd04c7119635b908ccefcd91cb0d5e18af97a7b01",
        "02737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
      ],
      "sequence": 4294967295,
      "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl"
    }
  ],
  "outputs": [
    {
      "value": 1234000,
      "address": "rs1qe4tnr7zhx95uvfw220k7eh9ke0rtducpp3hgjc",
      "covenant": {
        "type": 10,
        "action": "FINALIZE",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000",
          "6272656164",
          "00",
          "00000000",
          "02000000",
          "4942bbed4ebc9baf39e5a636884ac0d08b72ce5ae301d825726d210d24324fe8"
        ]
      }
    },
    {
      "value": 1999999440,
      "address": "rs1qrayzddcwjeqs93ejpxdrq5uxn5yxp68rp0fcxq",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "00000000023f650357a4de12f4d6b764f13ccfd473ab56d4390b6afb71941a429dc4b8cfc400000000ffffffffde7a5680851d3b3bb4509d2559ebd1d61f61e0ca6eaae82225c4c5c4b8e89d1a00000000ffffffff0250d41200000000000014cd5731f8573169c625ca53edecdcb6cbc6b6f3010a0720e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e3040000056272656164010004000000000402000000204942bbed4ebc9baf39e5a636884ac0d08b72ce5ae301d825726d210d24324fe8d09135770000000000141f4826b70e964102c732099a3053869d0860e8e30000000000000241183b5de76722cf361c3cb1b509f537b9fafdab25d724e1d8f37db75c77684496208cbaca9ac59362ab70ef16d483f7371a28a231272c8e481f1af99fe931e48a0121031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c880241db8152812f0b5db8c94663020019806c6b441a0ff8d5ab9c01a1aca2ac4a98a70a90a6fff5ccda93fe80c39a6dd04c7119635b908ccefcd91cb0d5e18af97a7b012102737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
}
```

Create, sign, and send a FINALIZE.

### HTTP Request

`POST /wallet/:id/finalize`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name in transferred state to finalize transfer for
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)


## Send REVOKE

```shell--vars
id='primary'
name='bread'
passphrase='secret123'
broadcast=true
sign=true
```

```shell--curl
curl $walleturl/$id/revoke \
  -X POST \
  --data '{
    "passphrase":"'$passphrase'",
    "name":"'$name'",
    "broadcast":'$broadcast',
    "sign":'$sign'
  }'
```

```shell--cli
> no CLI command available
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
const wallet = walletClient.wallet(id);

const options = {passphrase, name, broadcast};

(async () => {
  const result = await wallet.createRevoke(options);
  console.log(result);
})();
```

> Sample response:

```json
{
  "hash": "6785ee323e4619b29bcdc7f321dd428f4023ebabe81524e014b7d9c6b72c93cc",
  "witnessHash": "88bf88f2bcfbb4769b3172924641ef5104fdc5ac5eacb7a82efa47a4b9cda150",
  "mtime": 1580997666,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "8a8f44c1984ad59e5d69f8bab69abb048940ac9afcb6b69f5db7fa26b963383b",
        "index": 0
      },
      "witness": [
        "75b04e8eb6b9a8f8accbb0c4c4e7615bc9482b4a9d32cb280c05d6aae0cd1d9a4dbdd03a68b1e4599a99223067a2071fb772c7a5df7a284d614c6420adc863a601",
        "0340b9a23ad22b1031aebafbcde816f385f8ce37d4364b22415ea5e74d305a1752"
      ],
      "sequence": 4294967295,
      "address": "rs1qe4tnr7zhx95uvfw220k7eh9ke0rtducpp3hgjc"
    },
    {
      "prevout": {
        "hash": "7f468990f5cc5c63e88a1ab635e2534f2d731e34caee0a6a88d349251d8b292d",
        "index": 0
      },
      "witness": [
        "bf03452993be0678d8a25f87ea261a45a6237665c89dac89dc8a41cb7470fc1735d4d1336c880786a4b7b8dd3ae865add239f244d11c2a5a633131b0d267c5e201",
        "02737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
      ],
      "sequence": 4294967295,
      "address": "rs1q3qm3e6sxd0mzax54jx6p3th0p2adzxdx2tm3zl"
    }
  ],
  "outputs": [
    {
      "value": 1234000,
      "address": "rs1qe4tnr7zhx95uvfw220k7eh9ke0rtducpp3hgjc",
      "covenant": {
        "type": 11,
        "action": "REVOKE",
        "items": [
          "e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a",
          "e3040000"
        ]
      }
    },
    {
      "value": 2000000460,
      "address": "rs1q8utpm2zqajrwcaju0ldxjwwaad6cu8awkjevap",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "00000000028a8f44c1984ad59e5d69f8bab69abb048940ac9afcb6b69f5db7fa26b963383b00000000ffffffff7f468990f5cc5c63e88a1ab635e2534f2d731e34caee0a6a88d349251d8b292d00000000ffffffff0250d41200000000000014cd5731f8573169c625ca53edecdcb6cbc6b6f3010b0220e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e3040000cc9535770000000000143f161da840ec86ec765c7fda6939ddeb758e1fae000000000000024175b04e8eb6b9a8f8accbb0c4c4e7615bc9482b4a9d32cb280c05d6aae0cd1d9a4dbdd03a68b1e4599a99223067a2071fb772c7a5df7a284d614c6420adc863a601210340b9a23ad22b1031aebafbcde816f385f8ce37d4364b22415ea5e74d305a17520241bf03452993be0678d8a25f87ea261a45a6237665c89dac89dc8a41cb7470fc1735d4d1336c880786a4b7b8dd3ae865add239f244d11c2a5a633131b0d267c5e2012102737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
}
```

Create, sign, and send a REVOKE.

This method is a fail-safe for name owners whose keys are compromised and lose
control of their name. Before the transfer is finalized, a REVOKE can be sent
that not only cancels the transfer, but burns the name preventing any further
updates or transfers. The name can be reopened with a new auction after a set time.

### HTTP Request

`POST /wallet/:id/finalize`

### Post Parameters
Parameter | Description
--------- | ------------------
id <br> _string_ | wallet id
passphrase <br> _string_ | passphrase to unlock the wallet
name <br> _string_  | name in transferred state to revoke transfer for
sign <br> _bool_ | whether to sign the transaction
broadcast <br> _bool_ | whether to broadcast the transaction (must sign if true)
