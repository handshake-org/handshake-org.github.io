## Introduction

Handshake is a UTXO-based blockchain protocol which manages the
registration, renewal and transfer of DNS top-level domains (TLDs). Our naming
protocol differs from its predecessors in that it has no concept of
namespacing or subdomains at the consensus layer. Its purpose is _not_ to
replace DNS, but to replace the root zone file and the root servers.

The full node daemon, [hsd](https://github.com/handshake-org/hsd),
is written in Javascript and is a fork of [bcoin](https://bcoin.io). By
running a full node, you can participate in securing the network and
serving the root zone file embedded in the blockchain.

We also have a SPV client, [hnsd](https://github.com/handshake-org/hnsd),
which is written in C. It acts as a light client to the blockchain, as well
as a recursive name server. It can serve provable resource records and verify
payments without having the resource requirements of a full node.

By installing and/or contributing to Handshake, you are participating in a
decentralized open platform owned by the commons.

### Source Code

The latest source code is available on
[GitHub](https://github.com/handshake-org) under the [MIT license](https://opensource.org/licenses/mit-license.php).

### Coins

Handshake utilizes a utility coin system for name registration.
Handshake depends on the free and open source community to take ownership
and decentralize the system [https://handshake.org](https://handshake.org).

### Mailing List

You can subscribe to the GNU Mailman mailing list by e-mailing ‘subscribe’
to [devs@handshake.org](mailto:devs@handshake.org).

### IRC

A community IRC channel exists on Freenode in irc.freenode.net:#handshake.
