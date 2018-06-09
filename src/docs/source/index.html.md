---
title: Handshake API Reference

home_link: https://handshake-org.github.io

language_tabs: # must be one of https://git.io/vQNgJ
  - shell--curl: cURL
  - shell--cli: CLI
  - javascript

toc_footers:
  - <a href='https://github.com/handshake-org/hskd'>See the code on GitHub</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - clients
  - node
  - coin
  - transaction
  - node_rpc
  - node_rpc_general
  - node_rpc_chain
  - node_rpc_block
  - node_rpc_mempool
  - node_rpc_tx
  - node_rpc_mining
  - node_rpc_network
  - wallet
  - wallet_admin
  - wallet_tx
  - wallet_accounts
  - wallet_events
  - errors

search: true
---

# Introduction

Welcome to the hskd API!

The default hskd HTTP server listens on port (`12037` for main, `13037` for testnet, `14037` for regtest, and `15037` for simnet). It exposes a REST JSON, as well as a JSON-RPC api.

# Authentication
## Auth

```shell--curl
# default regtest port is 14037 (may be reconfigured by user), API key is required in URL
curl http://x:api-key@127.0.0.1:14037/

# examples in these docs will use an environment variable:
url=http://x:api-key@127.0.0.1:14037/
curl $url
```

```shell--cli
cli --api-key=api-key --network=regtest info

# store API key and network type in environment variables:
export HSKD_API_KEY=api-key
export HSKD_NETWORK=regtest
cli info
```

```javascript
const {NodeClient} = require('hsk-client');
const {Network} = require('hskd');
const network = Network.get('regtest');

// network type derived from hskd object, client object stores API key
const clientOptions = {
  network: network.type,
  port: network.rpcPort,
  apiKey: 'api-key'
}

const client = new NodeClient(clientOptions);

(async () => {
  const clientinfo = await client.getInfo();
  console.log(clientinfo);
})();
```

> Make sure to replace `api-key` with your own key.

Auth is accomplished via HTTP Basic Auth, using your node's API key.

<aside class="notice">
You must replace <code>api-key</code> with your personal API key.
</aside>

<aside class="warning">
If you intend to use API via network and setup <code>api-key</code>, make sure to setup <code>ssl</code> too.
</aside>
