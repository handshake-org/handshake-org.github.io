## Introduction

Handshake is a UTXO-based blockchain protocol which manages the registration,
renewal and transfer of DNS top-level domains (TLDs). Our naming protocol
differs from its predecessors in that it has no concept of namespacing or
subdomains at the consensus layer. Its purpose is _not_ to replace DNS,
but to replace the root zone file and the root servers.

The full node daemon, [hsd](https://github.com/handshake-org/hsd),
is written in Javascript and is a fork of [bcoin](https://bcoin.io). By
running a full node, you can participate in securing the network and
serving the root zone file embedded in the blockchain.

We also have a light client, [hnsd](https://github.com/handshake-org/hnsd),
which is written in C. It can verify blockchain data and serve provable
resource records without having the resource requirements of a full node.
It also acts as an authoritative name server over the Handshake root zone,
and a recursive name server pointed at the authoritative name server.

By installing and/or contributing to Handshake, you are participating in a
decentralized open platform owned by the commons.

### Source Code

The latest source code is available on
[GitHub](https://github.com/handshake-org) under the
[MIT license](https://opensource.org/licenses/mit-license.php).

### Coins

Handshake utilizes a utility coin system for name registration.
Handshake depends on the free and open source community to take ownership
and decentralize the system [https://handshake.org](https://handshake.org).

### Developer Communities

-   IRC: irc.libera.chat: #handshake.
-   Telegram: [Handshake Dev Chat](https://t.me/hns_tech).
