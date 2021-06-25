# How to Claim a Name

If you own a name in the existing root zone, or the Alexa top 100k, or you
reserved your name through a trademark claim, it is waiting for you on the
blockchain. You are able to claim it by publishing a _DNSSEC ownership
proof_ -- a cryptographic proof that you own the name on ICANN's system.

Your name _must_ have a valid DNSSEC setup in order for the claim to be
created. If you do not have DNSSEC set up, don't worry -- you can set it up
_after_ the handshake blockchain launches and proofs will still be accepted
retroactively. Here's some useful guides for setting DNSSEC up on popular DNS
services:

- Namecheap: [https://www.namecheap.com/support/knowledgebase/subcategory.aspx/2232/dnssec](https://www.namecheap.com/support/knowledgebase/subcategory.aspx/2232/dnssec)
- GoDaddy: [https://www.godaddy.com/help/dnssec-faq-6135](https://www.godaddy.com/help/dnssec-faq-6135)
- Gandi: [https://wiki.gandi.net/en/domains/dnssec](https://wiki.gandi.net/en/domains/dnssec)
- Name.com: [https://www.name.com/support/articles/205439058-Managing-DNSSEC](https://www.name.com/support/articles/205439058-Managing-DNSSEC)
- Hover: [https://help.hover.com/hc/en-us/articles/217281647-Understanding-and-managing-DNSSEC](https://help.hover.com/hc/en-us/articles/217281647-Understanding-and-managing-DNSSEC)
- Cloudflare: [https://support.cloudflare.com/hc/en-us/articles/209114378](https://support.cloudflare.com/hc/en-us/articles/209114378)

If you run your own nameserver, you're going to need some tools for managing
keys and signing your zonefile. BIND has a number of command-line tools for
accomplishing this:

- [https://linux.die.net/man/8/dnssec-keygen](https://linux.die.net/man/8/dnssec-keygen)
- [https://linux.die.net/man/8/dnssec-dsfromkey](https://linux.die.net/man/8/dnssec-dsfromkey)
- [https://linux.die.net/man/8/dnssec-signzone](https://linux.die.net/man/8/dnssec-signzone)

---

### Prerequisites

This guide assumes you have a running [hsd][hsd] node and have used the
[`selectwallet`][select] rpc method to select the wallet that will control
your name. Otherwise, the following instructions will assign control of your
name to a key in the `default` account of the `primary` wallet. This wallet
and account are automatically generated when your node is started for the
first time.

The [api docs][api] will be useful for understanding how to setup, configure,
and interact with your node and wallet with [hs-client][client].

For specific information on how to configure your hsd node, view this
[guide][config].

For specific information on setting up a wallet using your faucet mnemonic,
view this [guide][wallet]. For general information on creating wallets,
view the documentation [here][wallet-docs].

[hsd]: https://github.com/handshake-org/hsd
[select]: https://hsd-dev.org/api-docs/#selectwallet
[config]: https://hsd-dev.org/guides/config.html
[wallet]: https://hsd-dev.org/guides/wallet.html
[api]: https://hsd-dev.org/api-docs
[wallet-docs]: https://hsd-dev.org/api-docs/#wallet
[client]: https://github.com/handshake-org/hs-client

### Claiming your name

First, we need to create a TXT record which we will sign in our zone (say we
own example.com for instance):

``` bash
$ hsw-cli rpc createclaim example
{
  "name": "example",
  "target": "example.com.",
  "value": 1133761643,
  "size": 957,
  "fee": 19140,
  "block": "fb89a649e4667d8ffc4ce105faec7872ef47e0ce0e60a6a9e58e0b7cc3bb6147",
  "address": "rs1qz588tmrclt4x2v48nu4ty2dnyenusul8q5djcj",
  "txt": "hns-claim:qnPxvMRKAAAAAAAA+4mmSeRmfY/8TOEF+ux4cu9H4M4OYKap5Y4LfMO7YUcAFBUOdex4+uplMqefKrIpsyZnyHPn"
}
```

The `txt` field is what we need: it includes a commitment to a handshake
address we want the name to be associated with, along with a fee that we're
willing to pay the miner to mine our claim. This TXT record must be added to
our name's zone file and signed:

``` zone
...
example.com. 1800 IN TXT "hns-claim:qnPxvMRKAAAAAAAA+4mmSeRmfY/8TOEF+ux4cu9H4M4OYKap5Y4LfMO7YUcAFBUOdex4+uplMqefKrIpsyZnyHPn"
example.com. 1800 IN RRSIG TXT 5 2 1800 20190615140933 20180615131108 ...
```

The RR name of the TXT record (`example.com.` in this case) _must_ be equal
to the name shown in the `target` field output by `createclaim` (note: case
insensitive). Note that DNSSEC ownership proofs are a stricter subset of DNSSEC
proofs: your parent zones must operate through a series of typical `DS->DNSKEY`
referrals. No CNAMEs or wildcards are allowed, and each label separation (`.`)
must behave like a zone cut (with an appropriate child zone referral).

The ZSK which signs our TXT record must be signed by our zone's KSK. As per the
typical DNSSEC setup, our zone's KSK must be committed as a DS record in the
parent zone.

Once our proof is published on the DNS layer, we can use `sendclaim` to crawl
the relevant zones and create the proof.

``` bash
$ hsw-cli rpc sendclaim example
```

This will create and broadcast the proof to all of your peers, ultimately
ending up in a miner's mempool. Your claim should be mined within 5-20 minutes.
Once mined, you must wait 4,320 blocks (approx. 30 days) before your claim is
considered "mature".

Once the claim has reached maturity, you are able to bypass the auction process
by calling `sendupdate` on your claimed name.

``` bash
$ hsw-cli rpc sendupdate example \
  '{"records": [{"type":"NS", "ns":"icanhazip.com."}] }'
```

### Creating a proof by hand

If you already have DNSSEC setup, you can avoid publishing a TXT record
publicly by creating the proof locally. This requires that you have direct
access to your zone-signing keys. The private keys themselves must be stored in
BIND's private key format (v1.3) and naming convention.

We use [bns] for this task, which includes a command-line tool for creating
ownership proofs.

``` bash
$ npm install bns
$ bns-prove -b -K /path/to/keys example.com. \
  'hns-claim:qnPxvMRKAAAAAAAA+4mmSeRmfY/8TOEF+ux'
```

The above will output a base64 string which can then be passed to the RPC:

``` bash
$ hsd-cli rpc sendrawclaim 'base64-string'
```
