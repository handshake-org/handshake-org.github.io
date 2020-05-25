# RPC Calls - Network

## getconnectioncount

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getconnectioncount",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc getconnectioncount
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
  const result = await client.execute('getconnectioncount');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
8
```

Returns connection count.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |

## ping

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "ping",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc ping
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
  const result = await client.execute('ping');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Will send ping request to every connected peer.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getpeerinfo

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getpeerinfo",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc getpeerinfo
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
  const result = await client.execute('getpeerinfo');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  {
    "id": 65,
    "addr": "127.0.0.1:14038",
    "addrlocal": "127.0.0.1:42930",
    "name": "localhost",
    "services": "00000009",
    "relaytxes": true,
    "lastsend": 1527116003,
    "lastrecv": 1527116003,
    "bytessent": 20734,
    "bytesrecv": 19905,
    "conntime": 348,
    "timeoffset": 0,
    "pingtime": 0.001,
    "minping": 0,
    "version": 70015,
    "subver": "/hsd:0.0.0/",
    "inbound": false,
    "startingheight": 5456,
    "besthash": "43bc66d363025c8953d0920d0bdd5d78e88905687dc0321053ce8f4c6ca0319d",
    "bestheight": 5470,
    "banscore": 0,
    "inflight": [],
    "whitelisted": false
  },
  ...
]
```

Returns information about all connected peers.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |




## addnode

```javascript
let nodeAddr, cmd;
```

```shell--vars
nodeAddr='127.0.0.1:14038';
cmd='add'
```


```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "addnode",
    "params": [ "'$nodeAddr'", "'$cmd'" ]
  }'
```

```shell--cli
hsd-cli rpc addnode $nodeAddr $cmd
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
  const result = await client.execute('addnode', [ nodeAddr, cmd ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Adds or removes peers in Host List. 

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | addr | Required | IP Address of the Node.
2 | cmd | Required | Command

### Commands
Command | Description
---- | ----
add | Adds node to Host List and connects to it
onetry | Tries to connect to the given node
remove | Removes node from host list



## disconnectnode

```javascript
let nodeAddr;
```

```shell--vars
nodeAddr='127.0.0.1:14038';
```


```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "disconnectnode",
    "params": [ "'$nodeAddr'" ]
  }'
```

```shell--cli
hsd-cli rpc disconnectnode $nodeAddr
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
  const result = await client.execute('disconnectnode', [ nodeAddr ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Disconnects node.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | addr | Required | IP Address of the Node.



## getaddednodeinfo

```javascript
let nodeAddr;
```

```shell--vars
nodeAddr='127.0.0.1:14038';
```

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getaddednodeinfo",
    "params": [ "'$nodeAddr'" ]
  }'
```

```shell--cli
hsd-cli rpc getaddednodeinfo $nodeAddr
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
  const result = await client.execute('getaddednodeinfo', [ nodeAddr ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  {
    "addednode": "127.0.0.1:14038",
    "connected": true,
    "addresses": [
      {
        "address": "127.0.0.1:14038",
        "connected": "outbound"
      }
    ]
  }
]
```

Returns node information from host list.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | addr | Required | IP Address of the Node.



## getnettotals

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getnettotals",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc getnettotals
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
  const result = await client.execute('getnettotals');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
{
  "totalbytesrecv": 42175,
  "totalbytessent": 42175,
  "timemillis": 1527116369308
}
```

Returns information about used network resources.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## getnetworkinfo

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "getnetworkinfo",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc getnetworkinfo
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
  const result = await client.execute('getnetworkinfo');
  console.log(result);
})();
```


> The above command returns JSON "result" like this:

```json
{
  "version": "0.0.0",
  "subversion": "/hsd:0.0.0/",
  "protocolversion": 70015,
  "localservices": "00000009",
  "localrelay": true,
  "timeoffset": 0,
  "networkactive": true,
  "connections": 2,
  "networks": [],
  "relayfee": 0.00001,
  "incrementalfee": 0,
  "localaddresses": [
    {
      "address": "18.188.224.12",
      "port": 14038,
      "score": 3
    }
  ],
  "warnings": ""
}
```

Returns local node's network information

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## setban

```javascript
let nodeAddr, cmd;
```

```shell--vars
nodeAddr='127.0.0.1:14038';
cmd='add'
```

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "setban",
    "params": [ "'$nodeAddr'", "'$cmd'" ]
  }'
```

```shell--cli
hsd-cli rpc setban $nodeAddr $cmd
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
  const result = await client.execute('setban', [ nodeAddr, cmd ]);
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Adds or removes nodes from banlist.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
1 | addr | Required | IP Address of the Node.
2 | cmd | Required | Command

### Commands
Command | Description
---- | ----
add | Adds node to ban list, removes from host list, disconnects.
remove | Removes node from ban list



## listbanned

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "listbanned",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc listbanned
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
  const result = await client.execute('listbanned');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
[
  {
    "address": "127.0.0.1",
    "banned_until": 1527202858,
    "ban_created": 1527116458,
    "ban_reason": ""
  }
]
```

Lists all banned peers.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |



## clearbanned

```shell--curl
curl http://x:api-key@127.0.0.1:14037 \
  -X POST \
  --data '{
    "method": "clearbanned",
    "params": []
  }'
```

```shell--cli
hsd-cli rpc clearbanned
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
  const result = await client.execute('clearbanned');
  console.log(result);
})();
```

> The above command returns JSON "result" like this:

```json
null
```

Removes all banned peers.

### Params
N. | Name | Default |  Description
--------- | --------- | --------- | -----------
None. |
