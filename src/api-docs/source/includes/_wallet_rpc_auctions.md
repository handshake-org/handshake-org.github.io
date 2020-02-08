# RPC Calls - Wallet Auctions

## getnames (hsw)

```shell--cli
hsw-rpc getnames
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('getnames');
  console.log(result);
})();
```

> getnames returns JSON structured like this: 

```json
[
  {
    "name": "why",
    "nameHash": "27b118c11562ebb2b11d94bbc1f23f3d78daea533766d929d39b580a2d37d4a4",
    "state": "CLOSED",
    "height": 189,
    "renewal": 398,
    "owner": {
      "hash": "7bd7c709e5d5e5cc2382f45daad29d280641bf9d1fdf5f88efb6a1809b16a01b",
      "index": 0
    },
    "value": 1000000,
    "highest": 3000000,
    "data": "00000000",
    "transfer": 0,
    "revoked": 0,
    "claimed": false,
    "weak": false,
    "stats": {
      "renewalPeriodStart": 398,
      "renewalPeriodEnd": 10398,
      "blocksUntilExpire": 9917,
      "daysUntilExpire": 34.43
    }
  },
  {
    "name": "trees",
    "nameHash": "92ec68524dbcc44bc3ff4847ed45e3a86789009d862499ce558c793498413cec",
    "state": "CLOSED",
    "height": 67,
    "renewal": 276,
    "owner": {
      "hash": "5d04759a92c5d3bd4ef6856ebcde45cd5ce4e8563a6377d9edac5161014940c9",
      "index": 0
    },
    "value": 5000000,
    "highest": 20000000,
    "data": "000a8c000906036e7331076578616d706c6503636f6d00010203040000000000000000000000000000000000",
    "transfer": 0,
    "revoked": 0,
    "claimed": false,
    "weak": false,
    "stats": {
      "renewalPeriodStart": 276,
      "renewalPeriodEnd": 10276,
      "blocksUntilExpire": 9795,
      "daysUntilExpire": 34.01
    }
  },
  {
    "name": "tba",
    "nameHash": "a73f93785b1fc9b1973579cf2b3f1a08a832d462a5e8ad6e5ec75883ccd90f50",
    "state": "CLOSED",
    "height": 434,
    "renewal": 477,
    "owner": {
      "hash": "ded558796b20bead377c618c76641de0560dc4323a4b24d4131e7434d3077509",
      "index": 0
    },
    "value": 0,
    "highest": 1000000,
    "data": "00000000",
    "transfer": 0,
    "revoked": 0,
    "claimed": false,
    "weak": false,
    "stats": {
      "renewalPeriodStart": 477,
      "renewalPeriodEnd": 10477,
      "blocksUntilExpire": 9996,
      "daysUntilExpire": 34.71
    }
  },
]
```

Your wallet tracks any name on which you have bid or opened. `getnames` returns info on each. This is different from the `hsd-rpc getnames` call which returns info on all names for which the node has data.


## sendopen

```shell--vars
name='possibility'
```

```shell--cli
hsw-rpc sendopen $name
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendopen', [ name ]);
  console.log(result);
})();
```

> sendopen returns JSON structured like this: 

```json
{
  "hash": "05ba8ab476f41213613813ebc63a14d7154857efc9a19b7e181852ab19c05e82",
  "witnessHash": "6afe4493d6b68d855db9685380ea6316a9d4b48212e584cbf383dccf1acbf94b",
  "mtime": 1537401957,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "837b802fbad06cab6c8f789c4745cc56d1498a651a04973c8b3db310d90fec42",
        "index": 0
      },
      "witness": [
        "cc603c24fd90881b00899751d634fad8cfc67ac1289de2475f5c09117db3037335eb9983d38113be4d7c1895514f7d0ff411d2e72dc3ebb444e811146958ebc601",
        "03b9843c1c40c210790e55052c3e8c56b49d2f0f1d00e8bdeb0237f076a128365a"
      ],
      "sequence": 4294967295,
      "address": "rs1q9jd8fgq8xa0drggyd6azggpeslacdzx5gr04ss"
    }
  ],
  "outputs": [
    {
      "value": 0,
      "address": "rs1qkk62444euknkya4qws9cg3ej3au24n635n4qye",
      "covenant": {
        "type": 2,
        "action": "OPEN",
        "items": [
          "01c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb",
          "00000000",
          "706f73736962696c697479"
        ]
      }
    },
    {
      "value": 999996200,
      "address": "rs1qew8r8c2c74zpmkhwmxu6jkrhwmgegl5h6cfaz3",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000001837b802fbad06cab6c8f789c4745cc56d1498a651a04973c8b3db310d90fec4200000000ffffffff0200000000000000000014b5b4aad6b9e5a76276a0740b8447328f78aacf5102032001c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb04000000000b706f73736962696c69747928bb9a3b000000000014cb8e33e158f5441ddaeed9b9a9587776d1947e970000000000000241cc603c24fd90881b00899751d634fad8cfc67ac1289de2475f5c09117db3037335eb9983d38113be4d7c1895514f7d0ff411d2e72dc3ebb444e811146958ebc6012103b9843c1c40c210790e55052c3e8c56b49d2f0f1d00e8bdeb0237f076a128365a"
}
```
Once a name is available, a sendopen transaction starts the opening phase.

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to open bidding on


## getauctioninfo

```shell--vars
name='possibility'
```

```shell--cli
hsw-rpc getauctioninfo $name
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('getauctioninfo', [ name ]);
  console.log(result);
})();
```

> getauctioninfo returns JSON structured like this: 

```json
{
  "name": "possibility",
  "nameHash": "01c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb",
  "state": "OPENING",
  "height": 2003,
  "renewal": 2003,
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
    "openPeriodStart": 2003,
    "openPeriodEnd": 2014,
    "blocksUntilBidding": 10,
    "hoursUntilBidding": 0.83
  },
  "bids": [],
  "reveals": []
}
```
Once the open period begins, we can monitor the auction using `getauctioninfo`. Use `hsd-rpc getnameinfo` to monitor a name prior to the start of bidding.

Note, by default your wallet will not track an auction unless you have participated in some form (sendopen, sendbid).

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to get auction info of


## sendbid

```shell--vars
name='possibility'
amount=5.000000
lockup=10.000000
```

```shell--cli
hsw-rpc sendbid $name $amount $lockup
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendbid', [ name, amount, lockup ]);
  console.log(result);
})();
```
> sendbid returns JSON structured like this: 

```json
{
  "hash": "85bce02cc5cb8ba9ff4e23d84ce389310f50074a6b9a8b20b8643a56a4cb9f9a",
  "witnessHash": "78a33edde952c80dd05476afe1e5e6e0a942484feb914e8ecf4c4b66329940a9",
  "mtime": 1537402434,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "5f7892816226f3f753dfd003eea4f565fa699a5b29bafde27b6628b1a2966910",
        "index": 0
      },
      "witness": [
        "bfab12daf81378ad40c46d037a52ffd4f3374c6f71cd6997b067ea9b498e29ac359cf9b267265f31741b28916a7d3da3021ca60539473d59cef3dc88b25c9e9801",
        "03b9843c1c40c210790e55052c3e8c56b49d2f0f1d00e8bdeb0237f076a128365a"
      ],
      "sequence": 4294967295,
      "address": "rs1q9jd8fgq8xa0drggyd6azggpeslacdzx5gr04ss"
    }
  ],
  "outputs": [
    {
      "value": 10000000,
      "address": "rs1qj3jpnvrs8afqmhpqanvlyc7m25duaxj4txaru5",
      "covenant": {
        "type": 3,
        "action": "BID",
        "items": [
          "01c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb",
          "d3070000",
          "706f73736962696c697479",
          "001361beb541240738829f101e842c76b9666d1bc4a87299a8ed6a9d2127ed61"
        ]
      }
    },
    {
      "value": 990004940,
      "address": "rs1qd7xx0qnn5qpnmcuadhnz99q6sydfgq8fvg6e4v",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "00000000015f7892816226f3f753dfd003eea4f565fa699a5b29bafde27b6628b1a296691000000000ffffffff0280969800000000000014946419b0703f520ddc20ecd9f263db551bce9a5503042001c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb04d30700000b706f73736962696c69747920001361beb541240738829f101e842c76b9666d1bc4a87299a8ed6a9d2127ed61cc46023b0000000000146f8c678273a0033de39d6de622941a811a9400e90000000000000241bfab12daf81378ad40c46d037a52ffd4f3374c6f71cd6997b067ea9b498e29ac359cf9b267265f31741b28916a7d3da3021ca60539473d59cef3dc88b25c9e98012103b9843c1c40c210790e55052c3e8c56b49d2f0f1d00e8bdeb0237f076a128365a"
}
```
The OPEN period is followed by the BIDDING period. Use `sendbid` to place a bid.

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to bid on
amount | Required | amount to bid (in HNS)
lockup | Required | amount to lock up to blind your bid (must be greater than bid amount)


## getbids


```shell--cli
hsw-rpc getbids
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('getbids');
  console.log(result);
})();
```
> getbids returns JSON structured like this: 

```json
[
  {
    "name": "why",
    "nameHash": "27b118c11562ebb2b11d94bbc1f23f3d78daea533766d929d39b580a2d37d4a4",
    "prevout": {
      "hash": "044aef8c1e61a3975bfa75dc9d6e1b19ce231ffcc019f97049543b2e12a692a6",
      "index": 0
    },
    "value": 3000000,
    "lockup": 4000000,
    "blind": "0ddd08f20581b7adadf881b80c5d044b17cf6b1965bf4c56815cca390d9c41db",
    "own": true
  },
  {
    "name": "trees",
    "nameHash": "92ec68524dbcc44bc3ff4847ed45e3a86789009d862499ce558c793498413cec",
    "prevout": {
      "hash": "9ae840429110809efde0f0743178ce2f66d021a3c9c875f486293f132e37151f",
      "index": 0
    },
    "value": 5000000,
    "lockup": 10000000,
    "blind": "a0943b12aa57ec0b3e6371be5b75cc895d0f78a7c5367c065bd388aebe6051a5",
    "own": true
  }
]

```
getbids returns a list of all the bids placed by your wallet.

### Params
none


## sendreveal

```shell--vars
name='possibility'
```

```shell--cli
hsw-rpc sendreveal $name
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendreveal', [ name ]);
  console.log(result);
})();
```

> sendreveal returns JSON structured like this: 

```json
{
  "hash": "e8f576a85d87adffeef7a9bfbf79cf8782750592911f095fe39dd9fa1e73b650",
  "witnessHash": "9f3458a6e1d32c9aad971cb52792f106f9f9a0a640a597098e98b47befe31be6",
  "mtime": 1537403274,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "22ebf77857e063c45dd0656ade0b8c5a29e255fefe55b1905fb799a9d075a552",
        "index": 0
      },
      "witness": [
        "5a43e3d1b90e28a550cca1da5950f846f82dc71d2f61b78ca1a4aadfef7d963e30fb33f1866139f02d24470948120e92a35ea3d6f7fa3ab569e9893f9983f86801",
        "03b98187d5521400df71917c0cded095e12a0134532e9db36b2f2d5e7958c9ef65"
      ],
      "sequence": 4294967295,
      "address": "rs1q6jh3ujj9a28svzpva2lamsqyx8vm78zer8rfyp"
    },
    {
      "prevout": {
        "hash": "85bce02cc5cb8ba9ff4e23d84ce389310f50074a6b9a8b20b8643a56a4cb9f9a",
        "index": 0
      },
      "witness": [
        "286caf0d7901660c5c6efffede32be2ba4811495c6afdc23ece3f53537aed85f4829e7c47516d15e02456f1efb798e0692a43ca06d96499c01954d2f23ac0a6801",
        "023bedd07f6cd16dc2699ec2b2451e2d8004fab99666e8e6dbc7286ed24be01f08"
      ],
      "sequence": 4294967295,
      "address": "rs1qj3jpnvrs8afqmhpqanvlyc7m25duaxj4txaru5"
    }
  ],
  "outputs": [
    {
      "value": 6000000,
      "address": "rs1q6jh3ujj9a28svzpva2lamsqyx8vm78zer8rfyp",
      "covenant": {
        "type": 4,
        "action": "REVEAL",
        "items": [
          "01c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb",
          "d3070000",
          "5b0e235bdc68fd23cc4877b566831490ea5be1a309af991027c89ff7be6822a8"
        ]
      }
    },
    {
      "value": 5000000,
      "address": "rs1qj3jpnvrs8afqmhpqanvlyc7m25duaxj4txaru5",
      "covenant": {
        "type": 4,
        "action": "REVEAL",
        "items": [
          "01c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb",
          "d3070000",
          "6cffbc155303695d2d974155bfd1dac48b267b41238a7d7ff4b39d1d23affe2a"
        ]
      }
    },
    {
      "value": 10992400,
      "address": "rs1qva23vffrfmru8euzvnqdxsudc2c6f7rlk4fszz",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "000000000222ebf77857e063c45dd0656ade0b8c5a29e255fefe55b1905fb799a9d075a55200000000ffffffff85bce02cc5cb8ba9ff4e23d84ce389310f50074a6b9a8b20b8643a56a4cb9f9a00000000ffffffff03808d5b00000000000014d4af1e4a45ea8f06082ceabfddc00431d9bf1c5904032001c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb04d3070000205b0e235bdc68fd23cc4877b566831490ea5be1a309af991027c89ff7be6822a8404b4c00000000000014946419b0703f520ddc20ecd9f263db551bce9a5504032001c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb04d3070000206cffbc155303695d2d974155bfd1dac48b267b41238a7d7ff4b39d1d23affe2a10bba70000000000001467551625234ec7c3e78264c0d3438dc2b1a4f87f00000000000002415a43e3d1b90e28a550cca1da5950f846f82dc71d2f61b78ca1a4aadfef7d963e30fb33f1866139f02d24470948120e92a35ea3d6f7fa3ab569e9893f9983f868012103b98187d5521400df71917c0cded095e12a0134532e9db36b2f2d5e7958c9ef650241286caf0d7901660c5c6efffede32be2ba4811495c6afdc23ece3f53537aed85f4829e7c47516d15e02456f1efb798e0692a43ca06d96499c01954d2f23ac0a680121023bedd07f6cd16dc2699ec2b2451e2d8004fab99666e8e6dbc7286ed24be01f08"
}
```
The BIDDING period is followed by the REVEAL period, during which bidders must reveal their bids.

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to reveal bid for (`null` for all names)



## getreveals

```shell--cli
hsw-rpc getreveals
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('getreveals');
  console.log(result);
})();
```

> getreveals returns JSON structured like this: 

```json
[
   {
    "name": "why",
    "nameHash": "27b118c11562ebb2b11d94bbc1f23f3d78daea533766d929d39b580a2d37d4a4",
    "prevout": {
      "hash": "e3f45c48985a0722a8a124065af972be05356a6be124263f4b86590da0e61e36",
      "index": 0
    },
    "value": 3000000,
    "height": 211,
    "own": true
  },
  {
    "name": "trees",
    "nameHash": "92ec68524dbcc44bc3ff4847ed45e3a86789009d862499ce558c793498413cec",
    "prevout": {
      "hash": "bd64231b5c28ad6b2b9c463900856676c67beedeb6e3a9e94cf6a1d8563bcba3",
      "index": 0
    },
    "value": 5000000,
    "height": 89,
    "own": true
  }
]
```
getreveals returns all the reveal transactions sent by the wallet.

### Params
none


## sendredeem

```shell--vars
name='possibility'
```

```shell--cli
hsw-rpc sendredeem $name
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendredeem', [ name ]);
  console.log(result);
})();
```

> sendredeem returns JSON structured like this: 

```json
{
  "hash": "eca1bae09d78312f1f3177eafcde9f48c8d933f807cc276a9224003aba922018",
  "witnessHash": "f883350cefade0671380fdce71b88996d2a49be30bfd7e3ebb02020e097efe51",
  "mtime": 1537224055,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "76ad90abcde417d41d017b8d15b6980a804405aff72537c5cb99eb61a60cfee0",
        "index": 0
      },
      "witness": [
        "c5af2d7cee71f3079ec24d4e20387388ec44f6617b068e86a495f0b5649f99e916618d25be6d04a038071de074429bd4dbeda021916fc98e4a5a7c0a4e03ca2801",
        "0329d8c1750b74815e568f2c57ac5492a8e93b3b919334025d37c239b466988590"
      ],
      "sequence": 4294967295,
      "address": "rs1q79u92rxyaxejj3rqyu0kxhzaydxk4ruendeu42"
    },
    {
      "prevout": {
        "hash": "00c61039848c77220ecafdef2e189c30093ae086c5ed5fce473bd1ec0d0f37fd",
        "index": 0
      },
      "witness": [
        "264a2153120ae936dd1dd75a0d2174089158b99e77f10db34253ed87216a76de13baa857f0ae5e1c77ac85f0402d74cd3d3154cfafe06e59e07b15c6958c5b4101",
        "020eb07bca66b10617ffb17fe298a104a21789f4990cedee84577f66fe69656458"
      ],
      "sequence": 4294967295,
      "address": "rs1q0n93g7979gflgq680daemzx8slfg0tqreasrnf"
    }
  ],
  "outputs": [
    {
      "value": 2000000,
      "address": "rs1q79u92rxyaxejj3rqyu0kxhzaydxk4ruendeu42",
      "covenant": {
        "type": 5,
        "action": "REDEEM",
        "items": [
          "a761e2b31b2a10714810b3cb439b1ffe347a1019af1932db7e8ac4c62a34224a",
          "0c000000"
        ]
      }
    },
    {
      "value": 1000000720,
      "address": "rs1qx7yfyscwrwjw86spx88wdhgnj7ljkrxjmljx6j",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "000000000276ad90abcde417d41d017b8d15b6980a804405aff72537c5cb99eb61a60cfee000000000ffffffff00c61039848c77220ecafdef2e189c30093ae086c5ed5fce473bd1ec0d0f37fd00000000ffffffff0280841e00000000000014f178550cc4e9b3294460271f635c5d234d6a8f99050220a761e2b31b2a10714810b3cb439b1ffe347a1019af1932db7e8ac4c62a34224a040c000000d0cc9a3b000000000014378892430e1ba4e3ea0131cee6dd1397bf2b0cd20000000000000241c5af2d7cee71f3079ec24d4e20387388ec44f6617b068e86a495f0b5649f99e916618d25be6d04a038071de074429bd4dbeda021916fc98e4a5a7c0a4e03ca2801210329d8c1750b74815e568f2c57ac5492a8e93b3b919334025d37c239b4669885900241264a2153120ae936dd1dd75a0d2174089158b99e77f10db34253ed87216a76de13baa857f0ae5e1c77ac85f0402d74cd3d3154cfafe06e59e07b15c6958c5b410121020eb07bca66b10617ffb17fe298a104a21789f4990cedee84577f66fe69656458"
}
```

After the REVEAL period, the auction is CLOSED. The value locked up by losing bids
can be spent using a REDEEM covenant like any other coin. The winning bid can not
be redeemed.


### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to redeem a losing bid for (`null` for all names)


## sendupdate

```shell--vars
name='possibility'
```

```shell--cli
hsw-rpc sendupdate $name '{"records": [ {"type": "NS", "ns": "ns1.example.com.", "address": "1.2.3.4"} ]}'
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute(
    'sendupdate',
    [
      name,
      {records: [ {type: "NS", "ns": "ns1.example.com.", "address": "1.2.3.4"} ]}
    ]
  );
  console.log(result);
})();
```
> sendupdate returns JSON structured like this: 

```json
{
  "hash": "70a7bb8a015514934344590330bac7b2ed3adf716a41c3ead54fff83271e4462",
  "witnessHash": "9826b176811030b992c913ff2b9c7ac540216f97d9ea97a12aa170238ff1176d",
  "mtime": 1580945169,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "fba2b7020060ef7da7d0fb016e0e6fc7eefe6472521da6d1e096c3508154b97f",
        "index": 0
      },
      "witness": [
        "fda534512d04e56628d786a5d25a60f96a55462a5879b8f0c57941a3e89f33546d69a04b4fa035d856bd7dad9f089646fa937864d85bdddbea22478fac835ffe01",
        "031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c88"
      ],
      "sequence": 4294967295,
      "address": "rs1qrw8kdf4nehpam42s9h767qrucgpccuqyk5y9j3"
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
          "0001036e7331076578616d706c6503636f6d00"
        ]
      }
    },
    {
      "value": 2000000880,
      "address": "rs1qvnzn8krtydw39stqx0a0cwdly68tyus88r0qkt",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000002fba2b7020060ef7da7d0fb016e0e6fc7eefe6472521da6d1e096c3508154b97f00000000ffffffff4ce418e3fa835b63a5c93397c807cd07fd711501c7840163a9ca660cb4c0b10900000000ffffffff0250d412000000000000141b8f66a6b3cdc3ddd5502dfdaf007cc2038c7004070320e7a31a66848e215f978d8354f09ef148f17e1aa0812584dee98a128e9ec9222a04e3040000130001036e7331076578616d706c6503636f6d007097357700000000001464c533d86b235d12c16033fafc39bf268eb272070000000000000241fda534512d04e56628d786a5d25a60f96a55462a5879b8f0c57941a3e89f33546d69a04b4fa035d856bd7dad9f089646fa937864d85bdddbea22478fac835ffe0121031a7b023f3baf31ec7e730cc1535bdf26c642be367b3de2fb6b6a30d3c5cd5c880241f6d7da1c9d3a8dd87c5c8b1726399f5f41396f5143f8bf4db50ccc4c7c1506c62c5b7ccb1ded95a7de110c38110d5aa72bbee3c0a04d07683e639bbddb2899dd012102737c83b6d4f0e5ef855908de87a62f68992881581f1659549c9ad43035d692f9"
}
```

After the REVEAL period, the auction is CLOSED. The value locked up by the winning
bid is locked forever, although the name owner and the name state can still change.
The winning bidder can update the data resource associated with their name by sending
an UPDATE.

See the [Resource Object section](#resource-object) for details on formatting the name resource data.

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to update the data for
data | Required | JSON-encoded resource


## sendrenewal

```shell--cli
hsw-rpc sendrenewal $name
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendrenewal', [ name ]);
  console.log(result);
})();
```

> sendrenewal returns JSON structured like this: 

```json
{
  "hash": "9903a0083675a01b325ed01154bc36714591f5854eb9cc307d611b50a8507240",
  "witnessHash": "1b0707f8b7e04d880afd134a17ea6564c4e6ee71b0151694315e5701bd8d1827",
  "mtime": 1537461760,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "d3b7fbb819ecc817cacb17458d946dacbc4b4501e730d8022f2ab079ad40bdac",
        "index": 0
      },
      "witness": [
        "d9438712c602f69bf9129f5ec49d9b7b4dd0c7a46328d7037723fd3a5454ca245262e90836173832ca9a5616fd1f7271ea0eb0c65a0fbabfbe1e72ebf8aef0e101",
        "03b98187d5521400df71917c0cded095e12a0134532e9db36b2f2d5e7958c9ef65"
      ],
      "sequence": 4294967295,
      "address": "rs1q6jh3ujj9a28svzpva2lamsqyx8vm78zer8rfyp"
    },
    {
      "prevout": {
        "hash": "069fe62ea77e0ca1705eb3c5cdff19ea419868243d7f41b18d9af6f78221e152",
        "index": 0
      },
      "witness": [
        "f9ed8ffd9e73a13dbb5a411071ff7a14ff54e084a59d9831a6a28e94781b253d513cc52cee51d644249c045d68ec0a1d0812399549ca3cf6c3b185c3ae669a1301",
        "03b9843c1c40c210790e55052c3e8c56b49d2f0f1d00e8bdeb0237f076a128365a"
      ],
      "sequence": 4294967295,
      "address": "rs1q9jd8fgq8xa0drggyd6azggpeslacdzx5gr04ss"
    }
  ],
  "outputs": [
    {
      "value": 5000000,
      "address": "rs1q6jh3ujj9a28svzpva2lamsqyx8vm78zer8rfyp",
      "covenant": {
        "type": 8,
        "action": "RENEW",
        "items": [
          "01c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb",
          "d3070000",
          "40e9f4c63507c0e05b44b5944dac4dbed3603a330dda2691067e17079fa8b5b3"
        ]
      }
    },
    {
      "value": 1000003100,
      "address": "rs1qc4hu9nh28nea6wz0p9sla70lzzxcyas3mshnv3",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000002d3b7fbb819ecc817cacb17458d946dacbc4b4501e730d8022f2ab079ad40bdac00000000ffffffff069fe62ea77e0ca1705eb3c5cdff19ea419868243d7f41b18d9af6f78221e15200000000ffffffff02404b4c00000000000014d4af1e4a45ea8f06082ceabfddc00431d9bf1c5908032001c05e8ea3d1c347342ef11c50fe5a1f621c942f7f8f7e0ee329eb883f93f9eb04d30700002040e9f4c63507c0e05b44b5944dac4dbed3603a330dda2691067e17079fa8b5b31cd69a3b000000000014c56fc2ceea3cf3dd384f0961fef9ff108d8276110000000000000241d9438712c602f69bf9129f5ec49d9b7b4dd0c7a46328d7037723fd3a5454ca245262e90836173832ca9a5616fd1f7271ea0eb0c65a0fbabfbe1e72ebf8aef0e1012103b98187d5521400df71917c0cded095e12a0134532e9db36b2f2d5e7958c9ef650241f9ed8ffd9e73a13dbb5a411071ff7a14ff54e084a59d9831a6a28e94781b253d513cc52cee51d644249c045d68ec0a1d0812399549ca3cf6c3b185c3ae669a13012103b9843c1c40c210790e55052c3e8c56b49d2f0f1d00e8bdeb0237f076a128365a"
}
```

On mainnet, name ownership expires after two years. If the name owner does not
RENEW the name, it can be re-opened by any user. RENEW covenants commit to a 
a recent block hash to prevent pre-signing and prove physical ownership of controlling keys.
There is no cost besides the miner fee.


### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to renew ownership of


## sendtransfer

```shell--vars
name='possibility'
address='rs1qhrnda3ct3237e6hl0vyh4tz2e90wvaxnmdldfq'
```

```shell--cli
hsw-rpc sendtransfer $name $address
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendtransfer', [ name, address ]);
  console.log(result);
})();
```

> sendtransfer returns JSON structured like this: 

```json
{
  "hash": "c7fc96fa1b865a6139286b29626edf00ff286cb242c5fc65b3a78e0db1613a04",
  "witnessHash": "909d816d51471d0706eb3b2fb697bfdd8a8a77bab7965fc8dca595971d79d68a",
  "mtime": 1538011636,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "d90af01fda660069d6a83f857a5779d099ff342d0e6a2a0a3f869e70b9bcf334",
        "index": 0
      },
      "witness": [
        "26ae1f8b5886b458b0e68571195d69270f1ea574d6c94c69c8720389247543fe3ac23705fe10e1eec520ca567cb2836d5ba444e1aae1f8c884047b14873a186901",
        "02896c8c128f86f155e61b74aced241304dd7f94feee6510d22f70e1d1b6e42fff"
      ],
      "sequence": 4294967295,
      "address": "rs1qucar8syx0dt32nms6kh63y0xcgsa747jaexn40"
    },
    {
      "prevout": {
        "hash": "d90af01fda660069d6a83f857a5779d099ff342d0e6a2a0a3f869e70b9bcf334",
        "index": 1
      },
      "witness": [
        "9c8df6c7719a21f042dc6779fde9fd3cc208316b703b64e78685795d79cfc0db790c989055c6c0a83c34e95f8f8c68264a69a1c9b8399fa78c5983e9616ee0e201",
        "0287b251961dba18b138ff59e692024c0962c355cd328c78de0fb2176739209f88"
      ],
      "sequence": 4294967295,
      "address": "rs1qx40lfr2q8wknz3mxr4zknc44e3n88qm65y9vag"
    }
  ],
  "outputs": [
    {
      "value": 3000000,
      "address": "rs1qucar8syx0dt32nms6kh63y0xcgsa747jaexn40",
      "covenant": {
        "type": 9,
        "action": "TRANSFER",
        "items": [
          "08141335637fff1366102f06f2f7d7ac306e5d85c6d8e0f979c765db6a9ec894",
          "8b000000",
          "00",
          "ba1889638506b69aa1b4b6c5c867c09345d8a7c1"
        ]
      }
    },
    {
      "value": 1000004320,
      "address": "rs1qvylezfasshnad0v55403n6prttueaam6t4vt3t",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000002d90af01fda660069d6a83f857a5779d099ff342d0e6a2a0a3f869e70b9bcf33400000000ffffffffd90af01fda660069d6a83f857a5779d099ff342d0e6a2a0a3f869e70b9bcf33401000000ffffffff02c0c62d00000000000014e63a33c0867b57154f70d5afa891e6c221df57d209042008141335637fff1366102f06f2f7d7ac306e5d85c6d8e0f979c765db6a9ec894048b000000010014ba1889638506b69aa1b4b6c5c867c09345d8a7c1e0da9a3b000000000014613f9127b085e7d6bd94a55f19e8235af99ef77a000000000000024126ae1f8b5886b458b0e68571195d69270f1ea574d6c94c69c8720389247543fe3ac23705fe10e1eec520ca567cb2836d5ba444e1aae1f8c884047b14873a1869012102896c8c128f86f155e61b74aced241304dd7f94feee6510d22f70e1d1b6e42fff02419c8df6c7719a21f042dc6779fde9fd3cc208316b703b64e78685795d79cfc0db790c989055c6c0a83c34e95f8f8c68264a69a1c9b8399fa78c5983e9616ee0e201210287b251961dba18b138ff59e692024c0962c355cd328c78de0fb2176739209f88"
}

```

TRANSFER a name to a new address. Note that the output value of the UTXO still
does not change. On mainnet, the TRANSFER period lasts two days, after which the
original owner can FINALIZE the transfer. Any time before it is final,
the original owner can still CANCEL or REVOKE the transfer.


### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to transfer
address | Required | address to transfer name ownership to


## sendfinalize

```shell--vars
name='possibility'
```

```shell--cli
hsw-rpc sendfinalize $name
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendfinalize', [ name ]);
  console.log(result);
})();
```

> sendfinalize returns JSON structured like this: 

```json
{
  "hash": "6f82bf94fdc12794aeac0a99e2428dbf0456f3ab15624129f898c505a1deb26d",
  "witnessHash": "cd4487c4d19924f5d58d828327e97eff5c1051a3a8cfaf3380af054960407fee",
  "mtime": 1538012719,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "e3c2874727805184562b3bbe7ebea8a23646eb045c36d69449ae236d3242dbc4",
        "index": 0
      },
      "witness": [
        "54fdde711cd3e0ce60e33a9db4c66b7a097c899dd39c8c3ba81905391bfcfd594afe4121e679985c6b8343635a595dcb4be50eadba66857550d0e16b25c20aaf01",
        "035e3c18b9a34de4c6a0be3a51f293d9cdd634cb85351e5c6b0152e7b292ce34a5"
      ],
      "sequence": 4294967295,
      "address": "rs1qwyssp6plp4qhqag6yejd2ywp4s8dg4dcgzsj7g"
    },
    {
      "prevout": {
        "hash": "0a50562585e67f3e5754c57ed5a94c893f047a06d9efba3b5b29f69903b54a56",
        "index": 0
      },
      "witness": [
        "200c11b6e091df0230a95a62264a30f0f674d572d82c638430c64ecfaadef15f20425fcb44ade602107314cfeea954714bbff2fde43dad370ecc90a0b4ca176901",
        "03fc902c7ebd0f4bb7437f86c41a3a88f0940a0566746159b581cd4684f725c7c0"
      ],
      "sequence": 4294967295,
      "address": "rs1qj6340u3vv0vqe0uyjjlnlvqaljv07nydvdz2jv"
    }
  ],
  "outputs": [
    {
      "value": 1000000,
      "address": "rs1qhgvgjcu9q6mf4gd5kmzuse7qjdza3f7pm8gnmh",
      "covenant": {
        "type": 10,
        "action": "FINALIZE",
        "items": [
          "27b118c11562ebb2b11d94bbc1f23f3d78daea533766d929d39b580a2d37d4a4",
          "bd000000",
          "776879",
          "00",
          "3addb4abe0cc60dad8dcd25688883c62c328c025095d26125b8ff9005cc0823b"
        ]
      }
    },
    {
      "value": 1000003540,
      "address": "rs1q5y4lfnlvdvewe6wxfqzscv4j4l008fey82txyz",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000002e3c2874727805184562b3bbe7ebea8a23646eb045c36d69449ae236d3242dbc400000000ffffffff0a50562585e67f3e5754c57ed5a94c893f047a06d9efba3b5b29f69903b54a5600000000ffffffff0240420f00000000000014ba1889638506b69aa1b4b6c5c867c09345d8a7c10a052027b118c11562ebb2b11d94bbc1f23f3d78daea533766d929d39b580a2d37d4a404bd000000037768790100203addb4abe0cc60dad8dcd25688883c62c328c025095d26125b8ff9005cc0823bd4d79a3b000000000014a12bf4cfec6b32ece9c648050c32b2afdef3a724000000000000024154fdde711cd3e0ce60e33a9db4c66b7a097c899dd39c8c3ba81905391bfcfd594afe4121e679985c6b8343635a595dcb4be50eadba66857550d0e16b25c20aaf0121035e3c18b9a34de4c6a0be3a51f293d9cdd634cb85351e5c6b0152e7b292ce34a50241200c11b6e091df0230a95a62264a30f0f674d572d82c638430c64ecfaadef15f20425fcb44ade602107314cfeea954714bbff2fde43dad370ecc90a0b4ca1769012103fc902c7ebd0f4bb7437f86c41a3a88f0940a0566746159b581cd4684f725c7c0"
}
```

About 48 hours after a `TRANSFER`, the original owner can send a `FINALIZE` transaction, completing the transfer to a new address. The output address of the `FINALIZE` is the new owner's address.


### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to finalize


## sendcancel

```shell--vars
name='possibility'
```

```shell--cli
hsw-rpc sendcancel $name
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendcancel', [ name ]);
  console.log(result);
})();
```

> sendcancel returns JSON structured like this: 

```json
{
  "hash": "7bd7c709e5d5e5cc2382f45daad29d280641bf9d1fdf5f88efb6a1809b16a01b",
  "witnessHash": "244ccd42d9c20e783b4249959b75aef2601ec2ef7edd4d527342644fcd0b04a4",
  "mtime": 1538022969,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "40694cc1ffbe6009d15446258aea876e74392f46be0844d5a67cf50e0b419ed6",
        "index": 0
      },
      "witness": [
        "f2511d7c5dd174773ab1dc9023f5a1a26e70f324b345eb31f5093394633faf8b5b84ccd1fb6bd8db661cf7ab6aaca02bda34acad47e15db9cfc666e517a536c601",
        "023341e7b9a5dbd22050d71fed525a1380096bb947b7f79f17828eb8b81546e3df"
      ],
      "sequence": 4294967295,
      "address": "rs1qgaxr4vg3y00ctlnyszy9hx36n7cxycfc6h59f3"
    },
    {
      "prevout": {
        "hash": "aa24214cb776499cc0aa40d6c05d31bd0327b7639149f9766d7e22d184ec858b",
        "index": 0
      },
      "witness": [
        "6816716ef14e9dfaebfb1b74d80ed00b839d86a5d77f99bb935d67d0b4a2bff5628e2c5fb6ca4ad34535355ad197e4162d7a2a09a9147805bd24d351dbfb7cec01",
        "03fc902c7ebd0f4bb7437f86c41a3a88f0940a0566746159b581cd4684f725c7c0"
      ],
      "sequence": 4294967295,
      "address": "rs1qj6340u3vv0vqe0uyjjlnlvqaljv07nydvdz2jv"
    }
  ],
  "outputs": [
    {
      "value": 1000000,
      "address": "rs1qgaxr4vg3y00ctlnyszy9hx36n7cxycfc6h59f3",
      "covenant": {
        "type": 7,
        "action": "UPDATE",
        "items": [
          "27b118c11562ebb2b11d94bbc1f23f3d78daea533766d929d39b580a2d37d4a4",
          "bd000000",
          ""
        ]
      }
    },
    {
      "value": 1000000440,
      "address": "rs1qrm0fu5axhfeclqacw6maxsshzx9vcm9lecaj67",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "000000000240694cc1ffbe6009d15446258aea876e74392f46be0844d5a67cf50e0b419ed600000000ffffffffaa24214cb776499cc0aa40d6c05d31bd0327b7639149f9766d7e22d184ec858b00000000ffffffff0240420f00000000000014474c3ab11123df85fe6480885b9a3a9fb062613807032027b118c11562ebb2b11d94bbc1f23f3d78daea533766d929d39b580a2d37d4a404bd00000000b8cb9a3b0000000000141ede9e53a6ba738f83b876b7d34217118acc6cbf0000000000000241f2511d7c5dd174773ab1dc9023f5a1a26e70f324b345eb31f5093394633faf8b5b84ccd1fb6bd8db661cf7ab6aaca02bda34acad47e15db9cfc666e517a536c60121023341e7b9a5dbd22050d71fed525a1380096bb947b7f79f17828eb8b81546e3df02416816716ef14e9dfaebfb1b74d80ed00b839d86a5d77f99bb935d67d0b4a2bff5628e2c5fb6ca4ad34535355ad197e4162d7a2a09a9147805bd24d351dbfb7cec012103fc902c7ebd0f4bb7437f86c41a3a88f0940a0566746159b581cd4684f725c7c0"
}
```

After sending a `TRANSFER` but before sending a `FINALIZE`, the original owner can cancel the  transfer. The owner will retain control of the name. This is the recommended means of canceling a transfer. Not to be confused with a `REVOKE`, which is only to be used in the case of a stolen key.
There is no "cancel" covenant -- this transaction actually sends an `UPDATE`.


### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to cancel the in-progress transfer of


## sendrevoke

```shell--vars
name='possibility'
```

```shell--cli
hsw-rpc sendrevoke $name
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('sendrevoke', [ name ]);
  console.log(result);
})();
```

> sendrevoke returns JSON structured like this: 

```json
{
  "hash": "fb7761c46161c736853f56d1be41e76ff8f004b7a4b5f096b880221544ee99f8",
  "witnessHash": "2fc85765999cd443f660b8af1c44e86d755ad706f8cb9f21632eaebc165ec9c0",
  "mtime": 1538011729,
  "version": 0,
  "inputs": [
    {
      "prevout": {
        "hash": "c7fc96fa1b865a6139286b29626edf00ff286cb242c5fc65b3a78e0db1613a04",
        "index": 0
      },
      "witness": [
        "078cf39beab769eb3331b00c1d6c92f152883fcd3ee62f54c69db5b33dd2919d568e52f89ac1d3cd0cb88cba6e88b703a872d61d7a953886bb4b8dce4938e33e01",
        "02896c8c128f86f155e61b74aced241304dd7f94feee6510d22f70e1d1b6e42fff"
      ],
      "sequence": 4294967295,
      "address": "rs1qucar8syx0dt32nms6kh63y0xcgsa747jaexn40"
    },
    {
      "prevout": {
        "hash": "5e0a26e6ba89dfafd7cd5436ddd5c26180f8619dd8dfebfe27459c4b4ac2093f",
        "index": 0
      },
      "witness": [
        "cf4ce38d371515c47bc51d28476adc288bcd06d39a1d1acf85bc6d39fd88799d578768e873263723e4012f181f071dcde145998107f1d37ad476b6c594cf7de401",
        "03fc902c7ebd0f4bb7437f86c41a3a88f0940a0566746159b581cd4684f725c7c0"
      ],
      "sequence": 4294967295,
      "address": "rs1qj6340u3vv0vqe0uyjjlnlvqaljv07nydvdz2jv"
    }
  ],
  "outputs": [
    {
      "value": 3000000,
      "address": "rs1qucar8syx0dt32nms6kh63y0xcgsa747jaexn40",
      "covenant": {
        "type": 11,
        "action": "REVOKE",
        "items": [
          "08141335637fff1366102f06f2f7d7ac306e5d85c6d8e0f979c765db6a9ec894",
          "8b000000"
        ]
      }
    },
    {
      "value": 1000000460,
      "address": "rs1qk9qqak6mqp7lfd7dxpfdntdhsep7xj75ajracs",
      "covenant": {
        "type": 0,
        "action": "NONE",
        "items": []
      }
    }
  ],
  "locktime": 0,
  "hex": "0000000002c7fc96fa1b865a6139286b29626edf00ff286cb242c5fc65b3a78e0db1613a0400000000ffffffff5e0a26e6ba89dfafd7cd5436ddd5c26180f8619dd8dfebfe27459c4b4ac2093f00000000ffffffff02c0c62d00000000000014e63a33c0867b57154f70d5afa891e6c221df57d20b022008141335637fff1366102f06f2f7d7ac306e5d85c6d8e0f979c765db6a9ec894048b000000cccb9a3b000000000014b1400edb5b007df4b7cd3052d9adb78643e34bd40000000000000241078cf39beab769eb3331b00c1d6c92f152883fcd3ee62f54c69db5b33dd2919d568e52f89ac1d3cd0cb88cba6e88b703a872d61d7a953886bb4b8dce4938e33e012102896c8c128f86f155e61b74aced241304dd7f94feee6510d22f70e1d1b6e42fff0241cf4ce38d371515c47bc51d28476adc288bcd06d39a1d1acf85bc6d39fd88799d578768e873263723e4012f181f071dcde145998107f1d37ad476b6c594cf7de4012103fc902c7ebd0f4bb7437f86c41a3a88f0940a0566746159b581cd4684f725c7c0"
}
```

After sending a `TRANSFER` but before sending a `FINALIZE`, the original owner can `REVOKE`
the name transfer. This renders the name's output forever unspendable, and puts the name back up for bidding. This is intended as an action of last resort in the case that the owner's key has been compromised, leading to a grief battle between an attacker and the owner. 


### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to revoke the in-progress transfer of


## importnonce

```shell--vars
name='possibility'
address='rs1qhrnda3ct3237e6hl0vyh4tz2e90wvaxnmdldfq'
bid=1.123456
```

```shell--cli
hsw-rpc importnonce $name $address $bid
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.walletPort,
  apiKey: 'api-key'
}

const client = new WalletClient(clientOptions);

(async () => {
  const result = await client.execute('importnonce', [ name, address, bid ]);
  console.log(result);
})();
```

> importnonce deterministically regenerates a bid's nonce

```
064802bfe52159d6c744625b17b887834d26dcc04605190fb82e4b41862adf60
```

Deterministically regenerate the nonce for a bid.

### Params
Name | Default |  Description
--------- | --------- | ---------
name | Required | name to bid on
address | Required | address submitting the bid
value | Required | value of the bid (in HNS)
