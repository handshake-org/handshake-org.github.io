# RPC Calls - Names

## getnameinfo

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{ "method": "getnameinfo", "params": [ '$name'] }'
```

```shell--cli
hsd-rpc getnameinfo pi
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getnameinfo', [ '$name' ]);
  console.log(result);
})();
```

> getnameinfo returns JSON structured like this: ("info" is empty if name has not yet been auctioned).

```json
{
  "result": {
    "start": {
      "reserved": false,
      "week": 20,
      "start": 3024
    },
    "info": {
      "name": "pi",
      "nameHash": "512da52b8aba40722262447a53ff36f1ab854a5dd1ea1bf92d0aed18a50ebca9",
      "state": "CLOSED",
      "height": 7203,
      "renewal": 14636,
      "owner": {
        "hash": "47510cf5ba035cfc97f3e2e6cbe9c06e536fa87e81350343d30f2d021dc1dd36",
        "index": 0
      },
      "value": 1000000,
      "highest": 2000000,
      "data": "0000a8030a526567697374657265640477697468086e616d656261736501344765080d0980208120822e696f2f",
      "transfer": 0,
      "revoked": 0,
      "claimed": false,
      "weak": false,
      "stats": {
        "renewalPeriodStart": 14636,
        "renewalPeriodEnd": 23276,
        "blocksUntilExpire": 6154,
        "daysUntilExpire": 21.37
      }
    }
  }
}
```

Returns information on a given name. Use this function to query any name in any state.

### Params
Name | Default |  Description
--------- | --------- | --------- | -----------
name | Required | Name you wish to look up

### Return values
Name | Type |  Description
--------- | --------- | ---------
reserved | Boolean | true if the name is pre-reserved for it's existing owner to claim via DNSSEC proof.
week | int | estimated number of weeks after mainnet launch that name will become available (if not reserved)
start | int | exact block number that name will become available for bidding (if not reserved)
state | string | the current auction state of the name (BIDDING, REVEAL, CLOSED, REVOKED, TRANSFER)
height | int | block height at which auction started
renewal | int | block height at which renewal period begins
owner | int | UTXO to which the name belongs
value | int | penultimate bid amount, paid by winner
highest | int | highest bid amount, made by winner
data | serialized | the dns record data of the name stored on chain
claimed | boolean | true if the name was reserved and then unlocked and claimed via DNSSEC proof.



## getnames (hsd)

```shell--cli
hsd-rpc getnames
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getnames');
  console.log(result);
})();
```

> getnames returns JSON structured like this: (warning this does not yet support pagination)

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
    "name": "wizard",
    "nameHash": "89474af5538c39b1486a82202cf26a1d80e0a3630b7a0c413e9be1803a6bda4c",
    "state": "CLOSED",
    "height": 114,
    "renewal": 114,
    "owner": {
      "hash": "3f97093abcc2a39f88f99a98fdf86e590730699eada96afe62940c5018f92712",
      "index": 0
    },
    "value": 1000000,
    "highest": 5000000,
    "data": "",
    "transfer": 0,
    "revoked": 0,
    "claimed": false,
    "weak": false,
    "stats": {
      "renewalPeriodStart": 114,
      "renewalPeriodEnd": 10114,
      "blocksUntilExpire": 9633,
      "daysUntilExpire": 33.45
    }
  },
]
```

Returns info for all names that have been opened or claimed. NOTE: this is primarily for debugging on regtest or testnet. It does not yet support pagination. Note this is different from the `hsw-rpc getnames` which only returns info on the names your wallet is tracking.



## getnamebyhash

```shell--cli
hsd-rpc getnamebyhash $namehash
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getnamebyhash', [ '$namehash' ]);
  console.log(result);
})();
```

> getnamebyhash returns the name

```json

name

```

Returns the name for a from a given nameHash.

### Params
Name | Default |  Description
--------- | --------- | --------- | -----------
nameHash | Required | hash for which you want to the name.

### Return values
Name | Type |  Description
--------- | --------- | ---------
name | String



## getnameresource

```shell--cli
hsd-rpc getnameresource $name
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getnameresource', [ '$name' ]);
  console.log(result);
})();
```

> getnameresource returns JSON structured like this:

```json
{
  "records": [
    {
      "type": "GLUE4",
      "ns": "ns1.handshake.",
      "address": "44.231.6.183"
    },
    {
      "type": "GLUE4",
      "ns": "ns2.handshake.",
      "address": "23.239.11.203"
    },
    {
      "type": "NS",
      "ns": "ns1.handshake."
    }
  ]
}
```

Returns the resource records for the given name (added to the trie by the name owner using sendupdate).

### Params
Name | Default |  Description
--------- | --------- | --------- | -----------
name | Required | name for resource records.



## getnameproof

```shell--cli
hsd-rpc getnameproof $name
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getnameproof', [ '$name' ]);
  console.log(result);
})();
```

> getnameproof returns JSON structured like this:

```json
{
  "hash": "67ec4b4e0f51c7bbc708372dcfcd0ef84c16e3f0ec5eec7e3c414cb0409ebeef",
  "height": 478,
  "root": "f1917a89eea3fbcccf8eff42ab68afb67def86a8993d205b35cfeaf8388c6eb6",
  "name": "trees",
  "key": "92ec68524dbcc44bc3ff4847ed45e3a86789009d862499ce558c793498413cec",
  "proof": {
    "type": "TYPE_EXISTS",
    "depth": 4,
    "nodes": [
      [
        "",
        "f649bafd4cd34035ccdd3c1585c6722736f88251ac7c0a07ec71c5145f0aff93"
      ],
      [
        "",
        "5ca9816e027df9cbe464bcf5bd6148795e37d5f3165e4b3c9f017887a33a8630"
      ],
      [
        "",
        "2bf92bbf3664fe4a2ee8e0757327bef3ed5101a37639d2152dc0ab44b9c19ed4"
      ],
      [
        "",
        "5a79b7ad97d4cc3cc282e0f8ccdc0a1b0d97eeba145749aa7e23de5379aad4cd"
      ]
    ],
    "value": "0574726565732c00000a8c000906036e7331076578616d706c6503636f6d000102030400000000000000000000000000000000004300000014010000075d04759a92c5d3bd4ef6856ebcde45cd5ce4e8563a6377d9edac5161014940c900fe404b4c00fe002d3101"
  }
}
```

Returns the merkle trie proof for a given name.

### Params
Name | Default
--------- | ---------
name | Required


### Proof types
Type | Description
--------- | --------- |
'TYPE_DEADEND' | Name does not exist in trie.
'TYPE_SHORT' | Name does not exist in trie (path stops short).
'TYPE_COLLISION' | Name does not exist in trie (path collides with existing key).
'TYPE_EXISTS' | Name exists in trie. Returns array of nodes as proof.
'TYPE_UNKNOWN' | Some error occured.





## createclaim

```shell--cli
hsd-rpc createclaim $name
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('createclaim', [ '$name' ]);
  console.log(result);
})();
```

> createclaim returns the txt record to be signed and added to your name's zone file (using nytimes as example).

```json
{
  "name": "nytimes",
  "target": "nytimes.com.",
  "value": 1133774245,
  "size": 5120,
  "fee": 25600,
  "address": "rs1qgm0z8pa6l2zxhapddk9gh00wzhgjjcjfh2drjy",
  "txt": "hns-regtest:_QBkABRG3iOHuvqEa_QtbYqLve4V0SliSQA"
}

```
`createclaim` is for claiming a names in the existing root zone or the Alexa top 100k. These names are reserved and can be claimed by publishing a DNSSEC ownership proof -- a cryptographic proof that you own the name on ICANN's system.

The command returns the TXT record to be signed and added to your name's zone file. It includes a commitment to the handshake address you  want the name to be associated with, along with the fee that you are willing to pay the miner to mine our claim. This TXT record must be added to our name's zone file and signed. See [How to Claim a Name](https://handshake-org.github.io/guides/claims.html) for a more detailed guide.


### Params
Name | Default |  Description
--------- | --------- | --------- | -----------
name | Required | the reserved name for which you want to create a claim


## sendclaim

```shell--cli
hsd-rpc sendclaim $name
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('sendclaim', [ '$name' ]);
  console.log(result);
})();
```

> sendclaim broadcasts your ownership proof.

```json
```

Once our proof is published on the DNS layer, we can use `sendclaim` to crawl the relevant zones and create the proof.

`sendclaim` will create and broadcast the proof to all of your peers, ultimately ending up in a miner's mempool. Your claim should be mined within 5-20 minutes. Once mined, you must wait several blocks before your claim is considered "mature".

See the [README](https://github.com/handshake-org/hsd) for hsd or the [Name Claims](https://handshake-org.github.io/guides/claims.html) guide for more.

### Params
Name | Default |  Description
--------- | --------- | --------- | -----------
name | Required | name for which you wish to broadcast your ownership proof

## sendrawclaim

```shell--cli
hsd-rpc sendrawclaim <base64-string>
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('sendrawclaim', [ 'base64-string' ]);
  console.log(result);
})();
```

> send rawclaim allows you to publish your claim directly

```json
```

If you already have DNSSEC setup, you can avoid publishing a TXT record publicly by creating the proof locally. This requires that you have direct access to your zone-signing keys. The private keys themselves must be stored in BIND's private key format and naming convention.

See the [README](https://github.com/handshake-org/hsd) for hsd or the [Name Claims](https://handshake-org.github.io/guides/claims.html) guide for more.


### Params
Name | Default |  Description
--------- | --------- | --------- | -----------
claim | Required | raw serialized base64-string

## getdnssecproof

```javascript
let name;
```

```shell--vars
name='foo.bar';
```

```shell--cli
hsd-rpc getdnssecproof "$name"
```

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
    -X POST \
    --data '{"method":"getdnssecproof","params":["'$name'"]}'
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getdnssecproof', [ name ]);
  console.log(result);
})();
```

```json
{
  "zones": [...]
}
```

Query for and build a Handshake DNSSEC ownership proof.
This is the same proof that is included in a name claim. See
the [sendclaim](#sendclaim) RPC method to build a transaction that includes
the DNSSEC ownership proof. The `estimate` param is used to
validate the proof. If set to `false`, it will strictly require
the proof to be valid. If set to `true`, the proof will be built
and returned to the caller, even if it is invalid. The default
value for `estimate` is `false`.

A Handshake DNSSEC ownership proof is a more strict subset of
a DNSSEC proof. Each parent/child zone must operate through a series
of `DS->DNSKEY` relationships, no `CNAME`s or wildcards are allowed,
each label separation (`.`) must behave like a zone cut (with an
appropriate child zone referral) and weak cryptography is not allowed.
This means that SHA1 digests for `DS` hashes are not allowed,
and RSA-1024 is subject to be disabled via soft-fork.

### Params
Name | Default | Description
--------- | --------- | --------- |
name | | Domain name
estimate | false | No validation when true
verbose | true | Returns hex when false

## sendrawairdrop

```shell--cli
hsd-rpc sendrawairdrop <base64-string>
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('sendrawairdrop', [ 'base64-string' ]);
  console.log(result);
})();
```

> send rawairdrop allows you to publish your airdrop proof

```json
```

Airdrop proofs create brand new coins directly to a Handshake address

For details on how to create an airdrop proof, see the
[hs-airdrop](https://github.com/handshake-org/hs-airdrop)
tool.


### Params
Name | Default |  Description
--------- | --------- | --------- | -----------
claim | Required | raw serialized base64-string


## grindname

```shell--cli
hsd-rpc grindname $length
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getnameresource', [ $length ]);
  console.log(result);
})();
```

> grindname returns a randomly derived available name

```json
girnktqvqn
```

Grind a rolled-out available name.

### Params
Name | Default |  Description
--------- | --------- | --------- | -----------
length | 10 | length of name to generate



