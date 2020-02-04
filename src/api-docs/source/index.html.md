---
title: Handshake API Reference

home_link: /

language_tabs: # must be one of https://git.io/vQNgJ
  - shell--curl: cURL
  - shell--cli: CLI
  - javascript

toc_footers:
  - <a href='https://github.com/handshake-org/hsd'>See the code on GitHub</a>
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
  - node_rpc_names
  - wallet
  - wallet_admin
  - wallet_accounts
  - wallet_auctions
  - wallet_tx
  - sockets
  - node_sockets
  - wallet_sockets
  - errors

search: true
---

# Introduction

Welcome to the hsd API!

The default hsd HTTP server listens on port (`12037` for main, `13037` for testnet, `14037` for regtest, and `15037` for simnet). It exposes a REST JSON, as well as a JSON-RPC API.

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
export HSD_API_KEY=api-key
export HSD_NETWORK=regtest
cli info
```

```javascript
const {NodeClient} = require('hs-client');
const {Network} = require('hsd');
const network = Network.get('regtest');

// network type derived from hsd object, client object stores API key
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
You must replace <code>api-key</code> with your own, strong API key.<br>
<br>
A good way to generate a strong key is to use the <code>bcrypto</code> module that is installed as a 
dependency for <code>hsd</code>. From your hsd directory (or anywhere, if <code>bcrypto</code> is installed globally), run:<br>
<code>node -e "bcrypto=require('bcrypto'); console.log(bcrypto.random.randomBytes(32).toString('hex'))"</code><br>
Which will generate and output a securley random, 32-byte hex string.<br>
This string could be saved in <code>hsd.conf</code> to persist over restarts, or it may be passed to hsd
at launch (for example):<br>
<code>hsd --api-key=92ded8555d6f04e440ba540f2221349cbf799c454f7e08d3f16577d3e0127b0e</code><br>
<br>
For more information about <code>hsd.conf</code> and other launch parameters, see this
<a href="https://handshake-org.github.io/guides/config.html">hsd Configuration Guide</a>.
</aside>

<aside class="warning">
If you intend to use API via network and setup <code>api-key</code>, make sure to setup <code>ssl</code> too.
</aside>
