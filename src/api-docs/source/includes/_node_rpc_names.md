# RPC Calls - Names

## getnameinfo

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "getnameinfo", "params": [ 'pi'] }'
```

```shell--cli
hsd-cli rpc getnameinfo pi
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
  const result = await client.execute('getnameinfo', [ 'pi' ]);
  console.log(result);
})();
```

> getnameinfo returns JSON structured like this: 

```json
{
  "result": {
    "start": {
      "reserved":false, 
      "week":20,
      "start":3024 
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
  },
  "error":null,
  "id":null
}
```

Returns information on a given name. 

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
state | string | the current auction state of the name (BIDDING, CLOSED)
height | int | block height at which auction closed
renewal | int | block height at which rewnewal period begins
owner | int | UTXO to which the name belongs
value | int | penultimate bid amount, paid by winner
highest | int | highest bid amount, made by winner
data | serialized | the dns record data of the name stored on chain
transfer | ?? | ??
revoked | ?? | ??
claimed | boolean | true if the name was reserved and then unlocked and claimed via DNSSEC proof.
weak | ?? | ??





