# Wallet Sockets

## Wallet sockets - bsock

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const bsock = require('bsock');
const walletSocket = bsock.connect('<network wallet RPC port>');

// Authenticate and join wallet after connection to listen for events
walletSocket.on('connect', async () => {
  // Auth
  await walletSocket.call('auth', '<api-key>');

  // Join - All wallets
  await walletSocket.call('join', '*', '<admin token>');

  // Join - Specific wallet
  await walletSocket.call('join', '<wallet id>', '<wallet token>');
});

// Listen for new transactions
walletSocket.bind('tx', (walletID, details) => {
  console.log('Wallet -- TX Event, Wallet ID:\n', walletID);
  console.log('Wallet -- TX Event, TX Details:\n', details);
});

// Leave
walletSocket.call('leave', <wallet id>);
```

### Wallet Socket Authentication

Authentication with the API server must be completed before any other events
will be accepted.

Note that even if the server API key is disabled on the test server, the
`auth` event must still be sent to complete the handshake.

`emit('auth', 'server-api-key')`

The server will respond with a socket.io ACK packet once auth is completed.

### Joining a wallet

After creating a websocket and authing with the server, you must send a `join`
event to listen for events on a wallet. Join all wallets by passing `'*'`.
Leave a wallet with the `leave` event.
Wallet or admin token is required if `wallet-auth` is `true`.

### Listening for events

All wallet events return the `wallet-id` in addition to the JSON data described below.

## Wallet sockets - hs-client

```shell--curl
(See JavaScript example)
```

```shell--cli
(See JavaScript example)
```

```javascript
const {WalletClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

const walletOptions = {
  port: network.walletPort,
  apiKey: '<api-key>'
}

const walletClient = new WalletClient(walletOptions);

(async () => {
  // Connection and auth handled by opening client
  await walletClient.open();
  await walletClient.join('*', '<admin token>');
})();

// Listen for new transactions
walletClient.bind('tx', (walletID, details) => {
  console.log('Wallet -- TX Event, Wallet ID:\n', walletID);
  console.log('Wallet -- TX Event, TX Details:\n', details);
});

// Leave all wallets
walletClient.leave('*');
```

`hs-client` abstracts away the connection and authentication steps to make listening
for events much easier.

## Wallet sockets - Calls

The only wallet calls available are covered in the [previous section.](#wallet-sockets-bsock)

They are:

`auth`
`join`
`leave`


## Wallet sockets - Events

## wallet `tx`

> Example:

```
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

Emitted on transaction.

Returns tx details.

## `conflict`

Emitted on double spend.

Returns tx details of removed double spender.


## `confirmed`

Emitted when a transaction is confirmed.

Returns tx details.


## `unconfirmed`

Emitted if a transaction was changed from
confirmed->unconfirmed as the result of a reorg.

Returns tx details.


## `balance`

> Example:

```
{
  "wid": 1,
  "id": "primary",
  "unconfirmed": "8149.9999546",
  "confirmed": "8150.0",
  "lockedUnconfirmed": 0,
  "lockedConfirmed": 0
}
```

Emitted on balance update. Only emitted for
entire wallet balance (not individual accounts).

Returns Balance object.


## `address`

> Example:

```
[
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
]
```

Emitted when a transaction is received by the wallet account's current receive address,
causing the wallet to derive a new receive address.

Returns an array of [KeyRing](https://github.com/handshake-org/hsd/blob/master/lib/primitives/keyring.js) objects with new address details.
