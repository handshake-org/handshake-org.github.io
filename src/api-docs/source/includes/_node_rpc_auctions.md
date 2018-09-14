# RPC Calls - Names

## sendopen

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "sendopen", "params": [ "clevertld" ] }'
```

```shell--cli
hsd-cli rpc sendopen clevertld
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
  const result = await client.execute('sendopen', [ 'clevertld' ]);
  console.log(result);
})();
```

> sendopen returns JSON structured like this: 

```json

branch master
 {
   "hash": "08011cb959cae5bb4765a472a65335c7afaac27a38fb18c6adb28de0ebfa9670",
   "witnessHash": "9be4332d43a53204a8bfefcaeef12a0537b72b970dfb5c1076847d4a2e849897",
   "mtime": 1536864475,
   "version": 0,
   "inputs": [
     {
       "prevout": {
         "hash": "3f2813634cc5dce6553bc75f9d7d308183ec5a06b0be8beb4a6d0bd78dc631ba",
         "index": 1
       },
       "witness": [
         "464150741b5c4f8a6d73bcc7272d48872fe4bc7f87f07a29eab2a977a5b4b94c3d91ee7965f5f58bea2001f973b4cac5338d5bec48b0523f2581d3d49cdf3ff801",
         "030312902ef93a76f098f4052e89f6123aabdfa95bb369ddb1bd2680ed57fba938"
       ],
       "sequence": 4294967295,
       "address": "ts1qfgehgngqhhz8vh0mg9zv0a9ftd35lgmaarpn42"
     }
   ],
   "outputs": [
     {
       "value": 0,
       "address": "ts1qsghg5sdmzqn24wh8slcjz40c7p93829her4let",
       "covenant": {
         "type": 2,
         "action": "OPEN",
         "items": [
           "a987c9575123c2f7bbef2518ab99f9b09338844049e2bed193192efd4d2e7bc3",
           "00000000",
           "61726561"
         ]
       }
     },
     {
       "value": 4992660,
       "address": "ts1qdgy8adnmpsleky5e6cmejkt3zat2trgc3q392f",
       "covenant": {
         "type": 0,
         "action": "NONE",
         "items": []
       }
     }
   ],
   "locktime": 0,
   "hex": "00000000013f2813634cc5dce6553bc75f9d7d308183ec5a06b0be8beb4a6d0bd78dc631ba01000000ffffffff0200000000000000000014822e8a41bb1026aabae787f12155f8f04b13a8b7020320a987c9575123c2f7bbef2518ab99f9b09338844049e2bed193192efd4d2e7bc304000000000461726561942e4c0000000000
 00146a087eb67b0c3f9b1299d6379959711756a58d180000000000000241464150741b5c4f8a6d73bcc7272d48872fe4bc7f87f07a29eab2a977a5b4b94c3d91ee7965f5f58bea2001f973b4cac5338d5bec48b0523f2581d3d49cdf3ff80121030312902ef93a76f098f4052e89f6123aabdfa95bb369ddb1bd2680ed57fba938"
 }
```
Once we know the name is available, a sendopen transaction is necessary to start the bidding process.

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | The name for which you want to begin bidding (must be available).


## sendbid

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "sendbid", "params": [ "clevertld", 5, 10 ] }'
```

```shell--cli
hsd-cli rpc sendbid clevertld 5 10
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
  const result = await client.execute('sendbid', [ 'clevertld', 5, 10 ]);
  console.log(result);
})();
```

> sendbid returns JSON structured like this: 

```json
 {
   "hash": "3fdf46c5f33bd6b5e638969ba0cf286027611736f41e9c8974b69900cbfca1ee",
   "witnessHash": "66f0f4d5df22fbc89de7b631297586b948a04a335f52f36806aba9e7f53579e7",
   "mtime": 1536865252,
   "version": 0,
   "inputs": [
     {
       "prevout": {
         "hash": "eec7a5bfaf5079b9461512901e36097c0a55b6208c814da1d6762caabba634da",
         "index": 1
       },
       "witness": [
         "cc882ffb0f255721066ffeae201c3940400f51d867febf36a0d6a297e3277c9c57832ec60eeb9e5fbbb2b4085851b28a05274f56bf1096e12df528083343a0d601",
         "035f91fb8083568ee39045fd37b53450c4f1f3326209ff03753052b733d2abae42"
       ],
       "sequence": 4294967295,
       "address": "ts1qud8mlqe0f2lz7xcd2jdsejyrs4h6ghn8mtxpm0"
     }
   ],
   "outputs": [
     {
       "value": 200000,
       "address": "ts1qrdzp7ef9kasxjwlnfs7wt0sk9kmdfxl7xz6txd",
       "covenant": {
         "type": 3,
         "action": "BID",
         "items": [
           "f2e9068ee49346a66066ad4fa31b46a966862f1315fc97766a70cdd901f56481",
           "e0410000",
           "686f6c64",
           "986328f636dd8450f9e0b570e75357ef617703f1cdcd69920ebe91dcd0e75044"
         ]
       }
     },
     {
       "value": 4784620,
       "address": "ts1qsp8j82jc7yw7y9g2393n78trfq94g20h4lphaf",
       "covenant": {
         "type": 0,
         "action": "NONE",
         "items": []
       }
     }
   ],
   "locktime": 0,
   "hex": "0000000001eec7a5bfaf5079b9461512901e36097c0a55b6208c814da1d6762caabba634da01000000ffffffff02400d03000000000000141b441f6525b760693bf34c3ce5be162db6d49bfe030420f2e9068ee49346a66066ad4fa31b46a966862f1315fc97766a70cdd901f5648104e041000004686f6c6420986328f636dd84
 50f9e0b570e75357ef617703f1cdcd69920ebe91dcd0e75044ec014900000000000014804f23aa58f11de2150a89633f1d63480b5429f70000000000000241cc882ffb0f255721066ffeae201c3940400f51d867febf36a0d6a297e3277c9c57832ec60eeb9e5fbbb2b4085851b28a05274f56bf1096e12df528083343a0d60121035f91fb80
 83568ee39045fd37b53450c4f1f3326209ff03753052b733d2abae42"
 }
```
Once bidding is opened we can place masked bids on a name using sendbid.

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | The name for which you want to begin bidding (must be available).
amount | Required | Amount of HNS you wish to bid (denominated in HNS, decimal amounts allowed)
lockup | Required | Amount of HNS you wish to lockup to mask your bid. Must be greater than bid amount.

## getauctioninfo

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "getauctioninfo", "params": [ "clevertld" ] }'
```

```shell--cli
hsd-cli rpc getauctioninfo clevertld
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
  const result = await client.execute('getauctioninfo', [ 'clevertld' ]);
  console.log(result);
})();
```

> getuactioninfo returns JSON structured like this: 

```json
{
  "name": "clevertld",
  "nameHash": "f2e9068ee49346a66066ad4fa31b46a966862f1315fc97766a70cdd901f56481",
  "state": "BIDDING",
  "height": 16864,
  "renewal": 16864,
  "owner": {
    "hash": "0000000000000000000000000000000000000000000000000000000000000000",
    "index": 4294967295
  },
  "value": 0,
  "highest": 0,
  "data": "",
  "transfer": 0,
  "revoked": 0,
  "claimed": false,
  "weak": false,
  "stats": {
    "bidPeriodStart": 16937,
    "bidPeriodEnd": 17225,
    "blocksUntilReveal": 79,
    "hoursUntilReveal": 6.58
  },
  "bids": [
    {
      "name": "clevertld",
      "nameHash": "f2e9068ee49346a66066ad4fa31b46a966862f1315fc97766a70cdd901f56481",
      "prevout": {
        "hash": "3fdf46c5f33bd6b5e638969ba0cf286027611736f41e9c8974b69900cbfca1ee",
        "index": 0
      },
      "value": 100000,
      "lockup": 200000,
      "blind": "986328f636dd8450f9e0b570e75357ef617703f1cdcd69920ebe91dcd0e75044",
      "own": true
    },
    {
      "name": "clevertld",
      "nameHash": "f2e9068ee49346a66066ad4fa31b46a966862f1315fc97766a70cdd901f56481",
      "prevout": {
        "hash": "dde9cb868588203add46b6d7b11af475fe5dc9ef778872db5add26603fa683ce",
        "index": 0
      },
      "value": 100000,
      "lockup": 200000,
      "blind": "e6e7963fc01c88ea18a3604e25810b0fb576d2713cee5faec59c3b676973aff0",
      "own": true
    }
  ],
  "reveals": []
}
```
Once bidding is in progress we can monitor the auction using getauctioninfo.

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | The name for which you want auction info.


## sendreveal

## sendredeem

## sendupdate

## sendrenewal


















