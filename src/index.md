Handshake is a UTXO-based blockchain protocol which manages the
registration, renewal and transfer of DNS top-level domains (TLDs). Our naming
protocol differs from its predecessors in that it has no concept of
namespacing or subdomains at the consensus layer. Its purpose is _not_ to
replace DNS, but to replace the root zone file and the root servers.

The full node daemon, [hskd](https://github.com/handshake-org/hskd),
is written in Javascript and is a fork of [bcoin](https://bcoin.io). By
running a full node you, you can participate in securing the network and
serving the root zone file embedded in the blockchain.

We also have a SPV client, [hnsd](https://github.com/handshake-org/hnsd),
which is written in C. It acts as a light client to the blockchain, as well
as a recursive name server. It can serve provable resource records and verify
payments without having the resource requirements of a full node.

By installing Handshake, you are participating in a decentralized open
platform owned by the commons.

## Download

The latest source code is available on
[GitHub](https://github.com/handshake-org).

The source code is under an MIT license.

## Documentation

API documentation for hskd can be found
[here](/docs).

## Security Audit

The protocol and implementation are being audited by a team led by
[Dr. Matthew Green](https://isi.jhu.edu/~mgreen/) of John Hopkins University.
Dr. Green has previously led audits on the [libsodium](https://www.privateinternetaccess.com/blog/2017/08/libsodium-v1-0-12-and-v1-0-13-security-assessment/)
crypto library and the [Truecrypt](https://blog.cryptographyengineering.com/2015/04/02/truecrypt-report/)
disk encryption project. He is also a co-author of both the
[ Zerocoin ](http://zerocoin.org/talks_and_press) and
[ Zerocash ](http://zerocash-project.org/paper) papers. He is also a research scientist for the
[Zcash Company](https://z.cash/) and shares his thoughts on cryptographic
engineering on his [blog](https://blog.cryptographyengineering.com/).


## Coins

Handshake utilizes a utility coin system for name registration.
Handshake depends on the free and open source community to take ownership
and decentralize the system [https://handshake.org](https://handshake.org).

## Mailing List

You can subscribe to the GNU Mailman mailing list by e-mailing ‘subscribe’
to devs@handshake.org.

## IRC

A community IRC channel exists on Freenode in irc.freenode.net:#handshake.
