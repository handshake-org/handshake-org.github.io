## Handshake Protocol Summary

This guide is intended for developers with a working knowledge of the Bitcoin
protocol and its general consensus parameters. All values below describe mainnet
parameters.
[Testnet, regtest, and simnet may differ.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js)
Links reference the `hsd` codebase at the time of writing, during Testnet 4.

### Blockchain

- Block interval time:
[10 minutes](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js#L166)

- PoW Difficulty adjustment interval: [144 Blocks (one day)](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js#L158-L159)

- Maximum block size: [1000000 Bytes base block size](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/consensus.js#L160),
[4000000 Weight Units](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/consensus.js#L176-L177)

- Hash algorithm: "cBLAKE" --
[BLAKE2b256 keyed with KMAC256 (sha3)](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/mining/mine.js#L28-L29)

- Segregated Witness: Handshake is 100% SegWit, with witness commitment in the block header.

- Block headers: Handshake block headers are 240 bytes and
[commit to several tree roots:](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/mining/template.js#L417-L440)

  - merkle: Base transaction data

  - witness: Transaction witness data

  - tree: Root of the name-resource urkel tree. (updated every
  [36 blocks, about 4 times a day](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js#L295))

  - filter: (Not currently implemented) Will be used to commit to
  [Neutrino-style filters](https://github.com/bitcoin/bips/blob/master/bip-0158.mediawiki)

  - reserved: (Not currently implemented) Will be used for layer 2 expansion.

- Coinbase transactions:

    - Because Handshake is 100% SegWit, there is no `ScriptSig`, just witness data.
    Therefore,
    [to enforce transaction uniqueness](https://github.com/bitcoin/bips/blob/master/bip-0034.mediawiki),
    block heights are committed to the
    [`locktime` value of coinbase transactions.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/mining/template.js#L254-L255)

    - [Airdrops](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/mining/template.js#L310-L324)
    and [Claims](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/mining/template.js#L282-L308)
    are included in the coinbase transaction. Proofs for both of these types are
    [verified during block contextual checks, in `lib/primitives/tx.js`.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/primitives/tx.js#L418-L472)

### Money Supply

- Base unit: [dollarydoo](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/pkg.js#L52)

- 1 HNS = [1,000,000 dollarydoos](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/consensus.js#L30)

- Maximum total supply: [2,040,000,000 HNS](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/consensus.js#L111)

- Airdrop supply: [1,360,000,000 HNS](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/consensus.js#L86)
(Yep, the airdrop is 2/3 of the entire money supply! Available at genesis).

- Initial block subsidy: [2,000 HNS](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/consensus.js#L121)

- Block reward halving interval: [170,000 blocks (about 3 1/4 years)](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js#L91)

### Transactions

Because Handshake is SegWit-only, there are no output scripts, just addresses
(which themselves are witness program version + witness program hash).
A witness program can encode a public key or a script hash, but those keys and
scripts will appear in transaction _inputs_.

Handshake also introduces a new field in transaction outputs called a `covenant`.
All transaction outputs contain a
[value, an address, and a covenant.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/primitives/output.js#L255-L265)

### Covenants

The Handshake name auction system is run by transaction covenants. Currently all
[covenant types](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/covenants/rules.js#L43-L56)
operate on the naming system, but new covenants can be added that [don't affect
naming at all](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/primitives/covenant.js#L337-L350).

Covenants contain a [`type` and an array of items.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/primitives/covenant.js#L506-L519)
Items include auction details like a [name hash](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/wallet/wallet.js#L1526),
or a [blinded bid.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/wallet/wallet.js#L1641)

Name covenants are linked together in a chain, in the same way that transaction
inputs and outputs transfer value in a chain. In addition, some covenants must
identify the correct [name hash](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/covenants/rules.js#L1196)
to be valid. There are
[rules](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/covenants/rules.js#L1062)
about the sequence in which covenants can be spent. A transaction can have more
than one covenant, but the input and output indexes are linked.

#### These covenant types negotiate the name auctions:

| From --> | --> To     | Purpose   |
|----------|------------|-----------|
| `NONE`, `REDEEM`, `OPEN`   | `NONE`     | _Just sending money_ |
| `NONE`, `REDEEM`, `OPEN`   | `OPEN`     | _Start an auction for an available name_ |
| `NONE`, `REDEEM`, `OPEN`   | `BID`      | _Bid on an open auction for a name with a blinded value_ |
| `BID`    | `REVEAL`   | _Reveal the amount that was bid on a name_ |
| `REVEAL` | `REDEEM`   | _Sweep a losing auction bid back to wallet_ |
| `NONE`   | `CLAIM`    | _Names in the Alexa top 100,000 are reserved for legacy DNS owners_ |
| `CLAIM`, `REVEAL`  | `REGISTER` | _Update the DNS resource for an owned or won name (effectively burns coins)_ |

Because Handshake uses
[Vickrey Auctions](https://en.wikipedia.org/wiki/Vickrey_auction),
the highest bidder pays
[the second-highest bid.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/blockchain/chain.js#L1077-L1083)
In the event only one bid is submitted, that bidder can recover their entire bid
(when they `REGISTER`) in essence, paying the second-highest bid of zero.

Once a name has been `REGISTER`ed, it's value is locked forever, but the namestate
can still be changed.

#### These covenant types update "owned" names:

| From --> | --> To     | Purpose   |
|----------|------------|-----------|
| `REGISTER`, `UPDATE`, `RENEW`, `TRANSFER`, `FINALIZE` | `UPDATE` | _Update the DNS resource_ |
| `REGISTER`, `UPDATE`, `RENEW`, `TRANSFER`, `FINALIZE` | `RENEW` | _Renew name ownership before expiration_ |
| `REGISTER`, `UPDATE`, `RENEW`, `FINALIZE` | `TRANSFER` | _Initiate ownership transfer to new Handshake address_ |
| `TRANSFER` | `FINALIZE` | _Confirm ownership to new Handshake address (after lockup period)_ |
| `REGISTER`, `UPDATE`, `RENEW`, `TRANSFER`, `FINALIZE`  | `REVOKE` | _Permanently burn name -- used when a key is compromised_ |

Transfer and revocation actions are not allowed until
[about two weeks](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js#L310)
after the reveal period ends.

Names must be renewed within
[two years](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js#L250)
or they become available for new auctions again.

When a name is updated with either `REGISTER` or `UPDATE`, the new resource
is stored in a
[temporary data structure in the chain database.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/blockchain/chaindb.js#L1839)
Every 36 blocks (about 6 hours)
[the txn is committed to the urkel tree](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/blockchain/chaindb.js#L1842-L1843).

From the [whitepaper](https://handshake.org/files/handshake.txt):

> Because our tree is implemented as a series of append-only files, a
> commission interval is required to prevent history bloat, which may otherwise
> require the user of the software to compact their history regularly.

### Auctions

Name auctions progress through a [series of states based on time (i.e. block depth).](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/covenants/namestate.js#L127-L159)
The first time a name is seen on chain, it's state is
[set to the current block height.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/blockchain/chain.js#L908)
This height is saved in the database and used as a reference point for the entire
auction process. It can be [reset](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/covenants/namestate.js#L229)
after a name expires. Covenant types will be rejected if they are broadcast during the
wrong phase.

| Blocks since<br>previous state   | Approx. time | Current state     |
|----------------------------------|--------------|-------------------|
| (undefined name)                 |              | `CLOSED`          |
| < 37                             | ~6 hours     | `OPEN`            |
| < 720                            | ~5 days      | `BIDDING`         |
| < 1,440                          | ~10 days     | `REVEAL`          |
| > 0                              |              | `CLOSED`          |

When reserved names are `CLAIM`ed on chain, they enter a
[lockup period of about 30 days](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js#L243).
During the `LOCKED` phase,
[a reserved name can be re-claimed](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/blockchain/chain.js#L925-L936).
This is to provide solutions to legacy DNS name holders whose keys are compromised.

### Claims

Legacy DNS names in the Alexa top 100,000 are reserved for their current owners.
You can see the list in [names.json](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/covenants/names.json).

[Learn more about the claims list.](https://github.com/handshake-org/hs-names)

[Learn about on-chain name claims.](https://handshake-org.github.io/guides/claims.html)

#### RSA-1024 Soft Fork

DNSSEC proofs can be signed with a variety of algorithms. Unfortunately, this includes
1024-bit RSA. Keys of that limited size may be compromised in the near future,
much like SHA-1 has already been. For this reason, Handshake is
[already prepared for a soft fork](https://github.com/handshake-org/hsd/blob/master/lib/primitives/airdropkey.js#L109-L119)
to prohibit claims of this nature.

From the [whitepaper](https://handshake.org/files/handshake.txt):

> As a necessary effect of the activation of this fork, all names which were originally
> redeemed with RSA-1024 will be immediately revoked until redeemed again with a stronger key.
> This construction requires us to place a 6 month locktime on trasfers for names redeemed with RSA-1024.


### Name rollout

Un-reserved names are not all available immediately when mainnet launches. They
become available over the first year, based on a simple algorithm that
[compares the name's hash against a 52-week modulus.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/covenants/rules.js#L274-L295)

The new RPC call [getnameinfo](https://handshake-org.github.io/api-docs/#getnameinfo)
will return the `week` value, indicating when a given name is available.

The entire Handshake auction system is not activated until
[the first ten days](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/protocol/networks.js#L229)
of network life.

### Airdrop

Two thirds of the total currency supply is reserved for hundreds of thousands of
Internet citizens in the open-source software community. Public keys were collected
in various ways and added to a
[merkle tree](https://github.com/handshake-org/hs-tree-data),
whose root is
[committed](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/primitives/airdropproof.js#L22)
in consensus code. Airdrops are redeemed by submitting a proof to the network.

Note that airdrop outputs ARE NOT included in the genesis block like other cryptocurrency
airdrops. A Handshake airdrop is like a transaction that can be submitted at any time. In
fact, because the faucet recipients are recorded by address and not public key,
no signature is required to generate their airdrop transactions (of course a signature
is required to SPEND from the airdrop, like any other address). Because these transactions
can be generated and submitted by any node at any time, their
[fees are hard-coded, and enforced by consensus rules.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/primitives/airdropproof.js#L18-L19)

Airdrop recipients recorded by public key can anonymously redeem their coins
using a zero-knowledge proof.
[Learn more about the airdrop and how to claim yours!](https://github.com/handshake-org/hs-airdrop)

Airdrop double-redeems are prevented by a
[bitfield in the chain database.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/covenants/bitfield.js#L97-L125)

### Script OP Codes

[Three new OP codes have been added to the redeem script language.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/script/script.js#L566-L618)

| Hex Code | Name | Operation                         |
|----------|------|-----------------------------------|
| `0xd0`   | `OP_TYPE`              | _Get the covenant type (int) from the corresponding tx output and push on to stack_ |
| `0xd1`   | `OP_CHECKOUTPUT`       | _Consumes three stack items: `value`, `version`, and `address` (hash). Compares against corresponding tx output and pushes a (bool) on to stack._ |
| `0xd2`   | `OP_CHECKOUTPUTVERIFY` | _Same as above, but consumes the (bool) and throws an error if false._ |

These extra OP codes were added to Handshake to make name updates and transfers
more secure. For example, a script policy can be implemented that allows name
transfers only to a specific address. A hot/cold wallet system could be implemented
in which "cold" keys handle name transfers but "hot" keys are used for DNS resource updates.

Handshake also implements
[four additional hash function OP codes.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/script/script.js#L1111-L1138)
Each of these pop one item off the stack, and return the hash function digest
of that blob.

| Hex Code | Name          |
|----------|---------------|
| `0xc0`   | `OP_BLAKE160` |
| `0xc1`   | `OP_BLAKE256` |
| `0xc2`   | `OP_SHA3`     |
| `0xc3`   | `OP_KECCAK`   |


### SIGHASH_NOINPUT

[Handshake implements `SIGHASH_NOINPUT`.](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/primitives/tx.js#L279-L280)
It is defined in Bitcoin as [BIP 118](https://github.com/bitcoin/bips/blob/master/bip-0118.mediawiki),
and enables flexibility in off-chain and layer two protocols. It allows a tx to
spend from any output that "solves" the redeem script, instead of specifying
one single tx output by `txid` and `index`. It is implemented
[as a mask `0x40`](https://github.com/handshake-org/hsd/blob/b32c27bbb05e69b86c0e80aea3ecc394c5589186/lib/script/common.js#L417-L421),
so it can be combined with other SIGHASH flags like `SIGHASH_SINGLE`.
