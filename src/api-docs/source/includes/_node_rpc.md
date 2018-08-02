# RPC Calls - Node

```shell--curl
curl $url \
  -X POST \
  --data '{ "method": "<method>", "params": [...] "id": "some-id" }'
```

```shell--cli
hsd-cli rpc <method> <params>
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
  const result = await client.execute('<method>', [ <params> ]);
  console.log(result);
})();
```

> The above cURL command returns JSON structured like this:

```json
{"result": resultObject ,"error": errorObject, "id": passedID}
```

> Further examples will only include "result" part.
> CLI and Javascript calls return just the "result" or an error.




hsd RPC calls mimic Bitcoin Core's RPC.

RPC Calls are accepted at:
`POST /`

*Notes:*

*hsd-cli rpc and Javascript will either return an error OR the result.*

*Javascript result will return the "result" part of the object, not the id or error*

*If a Javascript error is encountered it will be thrown instead of returned in JSON*

*Be sure to check the debug log for error reports as well!*


### POST Parameters RPC
Parameter | Description
--------- | -----------
method  | Name of the RPC call
params  | Parameters accepted by method
id      | `int` Will be returned with the response (cURL only)
