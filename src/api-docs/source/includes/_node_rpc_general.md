## stop

```shell--curl
curl $url/ \
  -H 'Content-Type: application/json' \
  -X POST \
  --data '{ "method": "stop" }'
```

```shell--cli
hsd-cli rpc stop
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('stop');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
"Stopping."
```

Stops the running node.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getinfo

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "getinfo" }'
```

```shell--cli
hsd-cli rpc getinfo
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getinfo');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "version": "0.0.0",
  "protocolversion": 70015,
  "walletversion": 0,
  "balance": 0,
  "blocks": 205,
  "timeoffset": 0,
  "connections": 3,
  "proxy": "",
  "difficulty": 4.6565423739069247e-10,
  "testnet": true,
  "keypoololdest": 0,
  "keypoolsize": 0,
  "unlocked_until": 0,
  "paytxfee": 0.0002,
  "relayfee": 0.00001,
  "errors": ""
}
```

Returns general info


### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getmemoryinfo

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "getmemoryinfo" }'
```

```shell--cli
hsd-cli rpc getmemoryinfo
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('getmemoryinfo');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "total": 72,
  "jsHeap": 14,
  "jsHeapTotal": 17,
  "nativeHeap": 54,
  "external": 12
}
```

Returns Memory usage info.


### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## setloglevel

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "setloglevel",
    "params": [ "none" ]
  }'
```

```shell--cli
hsd-cli rpc setloglevel none
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('setloglevel', [ 'none' ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Change Log level of the running node.

Levels are: `NONE`, `ERROR`, `WARNING`, `INFO`, `DEBUG`, `SPAM`

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | level | Required | Level for the logger


## validateaddress

```javascript
let address;
```

```shell--vars
address='rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap';
```

```shell--curl
curl $url/ \
  -X POST \
  --data '{
    "method": "validateaddress",
    "params": [ "'$address'" ]
  }'
```

```shell--cli
hsd-cli rpc validateaddress $address
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('validateaddress', [ address ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "isvalid": true,
  "address": "rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap",
  "ismine": false,
  "iswatchonly": false
}
```

Validates address.


### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Address to validate



## createmultisig

```javascript
let nrequired, pubkey0, pubkey1, pubkey2;
```

```shell--vars
nrequired=2;
pubkey0='02e3d6bb36b0261628101ee67abd89d678522dc1199912512f814e70803652f395';
pubkey1='03d7ded41bb871936bf4d411371b25d706c572f28ef8d2613b45392e9f9c4348a5';
pubkey2='034bc2280e68d3bdd0ef0664e0ad2949a467344d8e59e435fe2d9be81e39f70f76';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "createmultisig",
    "params": [ '$nrequired', [ "'$pubkey0'", "'$pubkey1'", "'$pubkey2'" ] ]
  }'
```

```shell--cli
hsd-cli rpc createmultisig $nrequired '[ "'$pubkey0'", "'$pubkey1'", "'$pubkey2'" ]'
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('createmultisig', [ nrequired, [ pubkey0, pubkey1, pubkey2 ] ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "address": "rs1qlt977782vv7xxy45xgp9yzhtp90v6e5az9p05q7q8d2072m77xese5xxfl",
  "redeemScript": "522102e3d6bb36b0261628101ee67abd89d678522dc1199912512f814e70803652f39521034bc2280e68d3bdd0ef0664e0ad2949a467344d8e59e435fe2d9be81e39f70f762103d7ded41bb871936bf4d411371b25d706c572f28ef8d2613b45392e9f9c4348a553ae"
}
```

create multisig address

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | nrequired | Required | Required number of approvals for spending
2 | keyArray  | Required | Array of public keys


## signmessagewithprivkey

```javascript
let privkey, message;
```

```shell--vars
privkey='ENced8VD7YWkzPC8FTJ3gTTq4pQhF2PF79QS51mgZq7BgCfiEP5A';
message='hello';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "signmessagewithprivkey",
    "params": [ "'$privkey'", "'$message'"]
  }'
```

```shell--cli
hsd-cli rpc signmessagewithprivkey $privkey $message
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('signmessagewithprivkey', [ privkey, message ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
"arjD5y4glPea270IiExx04E+tTvryHKhWZcA2oy8svVHr9q/AvGA647UF2ICaIGJHazbRyyj3draiNnBns9aWQ=="
```


Signs message with private key. 
<aside>Note: Due to behavior of some shells like bash, if your message contains spaces you may need to add additional quotes like this: <code>"'"$message"'"</code></aside>

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | privkey | Required | Private key
1 | message | Required | Message you want to sign.


## verifymessage

```javascript
let address, signature, message;
```

```shell--vars
address='rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc';
signature='arjD5y4glPea270IiExx04E+tTvryHKhWZcA2oy8svVHr9q/AvGA647UF2ICaIGJHazbRyyj3draiNnBns9aWQ==';
message='hello';
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "verifymessage",
    "params": [ "'$address'", "'$signature'", "'$message'" ]
  }'
```

```shell--cli
hsd-cli rpc verifymessage $address $signature "$message"
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('verifymessage', [ address, signature, message ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
true
```

Verify signature.
<aside>Note: Due to behavior of some shells like bash, if your message contains spaces you may need to add additional quotes like this: <code>"'"$message"'"</code></aside>


### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | address | Required | Address of the signer
2 | signature | Required | Signature of signed message
3 | message | Required | Message that was signed

## setmocktime

```javascript
let timestamp;
```

```shell--vars
timestamp=1503058155;
```

```shell--curl
curl $url \
  -X POST \
  --data '{
    "method": "setmocktime",
    "params": [ '$timestamp' ]
  }'
```

```shell--cli
hsd-cli rpc setmocktime $timestamp
```

```javascript
const {NodeClient} = require('hsd-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const result = await client.execute('setmocktime', [ timestamp ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```


Changes network time (This is consensus-critical)

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | timestamp | Required | timestamp to change to
