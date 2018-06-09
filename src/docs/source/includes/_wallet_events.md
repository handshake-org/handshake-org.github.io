# Wallet Events

## Using Wallet Sockets
Wallet events use the socket.io protocol.

Socket IO implementations:

- JS: https://github.com/socketio/socket.io-client
- Python: https://github.com/miguelgrinberg/python-socketio
- Go: https://github.com/googollee/go-socket.io
- C++: https://github.com/socketio/socket.io-client-cpp

### Wallet Socket Auth

Authentication with the API server must be completed before any other events
will be accepted.

Note that even if the server API key is disabled on the test server, the
`wallet auth` event must still be sent to complete the handshake.

`emit('wallet auth', 'server-api-key')`

The server will respond with a socket.io ACK packet once auth is completed.

### Listening on a wallet

After creating a websocket and authing with the server, you must send a `wallet
join` event to listen for events on a wallet.

`emit('wallet join', 'wallet-id', 'wallet-token')`

### Unlistening on a wallet

`emit('wallet leave', 'wallet-id')`


## `version`

Emitted on connection.

Returns version. Object in the form:
`[{ version: '0.0.0-alpha', agent: '/hskd:0.0.0-alpha/', network: 'main' }]`.

## `wallet tx`

Received on transaction.

> Example:

``` json
  {
    "wid": 1,
    "id": "primary",
    "hash": "bc0f93bb233fdf42a25a086ffb744fcb4f64afe6f5d4243da8e3745835fd57b3",
    "height": -1,
    "block": null,
    "time": 0,
    "mtime": 1528468930,
    "date": "1970-01-01T00:00:00Z",
    "mdate": "2018-06-08T14:42:10Z",
    "size": 215,
    "virtualSize": 140,
    "fee": 2800,
    "rate": 20000,
    "confirmations": 0,
    "inputs": [
      {
        "value": 500002800,
        "address": "rs1q7qumafugfglg268djelwr7ps4l2uh2vsdpfnuc",
        "path": {
          "name": "default",
          "account": 0,
          "change": false,
          "derivation": "m/0'/0/0"
        }
      }
    ],
    "outputs": [
      {
        "value": 100000000,
        "address": "rs1q7rvnwj3vaqxrwuv87j7xc6ye83tpevfkvhzsap",
        "covenant": {
          "type": 0,
          "items": []
        },
        "path": {
          "name": "default",
          "account": 0,
          "change": false,
          "derivation": "m/0'/0/1"
        }
      },
      {
        "value": 400000000,
        "address": "rs1q2x2suqr44gjn2plm3f99v2ae6ead3rpat9qtzg",
        "covenant": {
          "type": 0,
          "items": []
        },
        "path": {
          "name": "default",
          "account": 0,
          "change": true,
          "derivation": "m/0'/1/4"
        }
      }
    ],
    "tx": "0000000001758758e600061e62b92831cb40163011e07bd42cac34467f7d34f57c4a921e35000000000241825ebb96f395c02d3cdce7f88594dab343347879dd96af29320bf020f2c5677d4ab7ef79349007d562a4cdafb54d8e1cbd538275deef1b78eb945155315ae648012102deb957b2e4ebb246e1ecb27a4dc7d142504e70a420adb3cf40f9fb5d3928fdf9ffffffff0200e1f505000000000014f0d9374a2ce80c377187f4bc6c68993c561cb13600000084d71700000000001451950e0075aa253507fb8a4a562bb9d67ad88c3d000000000000"
  }

```

## `wallet conflict`

Received on double spend.

Returns tx details of removed double spender.

## `wallet confirmed`

Received when a transaction is confirmed.

Returns tx details.

## `wallet unconfirmed`

Received if a transaction was changed from
confirmed->unconfirmed as the result of a reorg.

Returns tx details.

## `wallet balance`

Received on balance update. Only emitted for
entire wallet balance (not individual accounts).

> Example:

``` json
{
  "wid": 1,
  "id": "primary",
  "unconfirmed": "8149.9999546",
  "confirmed": "8150.0",
  "lockedUnconfirmed": 0,
  "lockedConfirmed": 0
}
```

## `wallet address`

Received when a new address is derived.

> Example:

``` json
{
  "wid": 1,
  "id": "primary",
  "name": "default",
  "account": 0,
  "branch": 0,
  "index": 9,
  "nested": false,
  "publicKey": "031a407b5219789b36b368a926fd9f0ea4817e3f6691a46454d8d01c71bff1096e",
  "script": null,
  "type": "pubkeyhash",
  "address": "rs1qryvfn5wzdd0wajpjjzs00s64nqxv0w077jz9gd"
}
```
