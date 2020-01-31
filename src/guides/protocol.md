## Handshake Protocol Summary

This guide is intended for developers with a working knowledge of the Bitcoin
protocol and its general consensus parameters. All values below describe mainnet
parameters.
[Testnet, regtest, and simnet may differ.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js)
Links reference the `hsd` codebase at the time of writing, just before main net launch.

### Blockchain

- Block interval time:
[10 minutes](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L174)

- PoW difficulty adjustments are computed after every block, targeting
[144 blocks per day](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L160-L182).

- Maximum block size: [1000000 Bytes base block size](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/consensus.js#L160),
[4000000 Weight Units](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/consensus.js#L176)

- Hash algorithm:
[BLAKE2b + SHA3](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/mining/mine.js#L31-L46)

- Hashes in Handshake are
[Big-Endian](https://github.com/handshake-org/hsd/commit/add3235d5b0de380257a6d069ca19ba717b60db4).

- Segregated Witness: Handshake is 100% SegWit, with witness commitment in the block header.

- Block headers: Handshake block headers are 256 bytes and
[commit to several tree roots:](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/abstractblock.js#L446-L465)

  - merkle: Base transaction data

  - witness: Transaction witness data

  - tree: Root of the name-resource urkel tree. (updated every
  [36 blocks, about 4 times a day](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L312))

  - reserved: (Not currently implemented) Will be used for layer 2 expansion.

- Proof-of-work hashing involves a
[reserialization of the block header](https://gist.githubusercontent.com/pinheadmz/7a54354f528d4db2f7dd09c3d75319ad/raw/74b1cf29838add8c117c842c2d3f3643d4e3499d/hsd_pow.txt)
including a `maskHash` designed to prevent block withholding attacks.

- Coinbase transactions:

    - Because Handshake is 100% SegWit, there is no `ScriptSig`, just witness data.
    Therefore,
    [to enforce transaction uniqueness](https://github.com/bitcoin/bips/blob/master/bip-0034.mediawiki),
    block heights are committed to the
    [`locktime` value of coinbase transactions.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/mining/template.js#L253)

    - [Airdrops](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/mining/template.js#L308-L322)
    and [Claims](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/mining/template.js#L280-L306)
    are included in the coinbase transaction. Proofs for both of these types are verified during
    [TX input checks](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/tx.js#L425-L479)

### Money Supply

- Base unit: [dollarydoo](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/pkg.js#L52)

- 1 HNS = [1,000,000 dollarydoos](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/consensus.js#L16-L30)

- Maximum total supply: [2,040,000,000 HNS](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/consensus.js#L111)

- Airdrop supply: [1,360,000,000 HNS](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/consensus.js#L86)
The airdrop is 2/3 of the entire coin supply.

- Initial block subsidy: [2,000 HNS](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/consensus.js#L121)

- Block reward halving interval: [170,000 blocks (about 3 1/4 years)](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L99)

### Transactions

Because Handshake is SegWit-only, there are no output scripts, just addresses
(which themselves are witness program version + witness program hash).
A witness program can encode a public key or a script hash, but those keys and
scripts will appear in transaction _inputs_ as witness stack items.

Handshake also introduces a new field in transaction outputs called a `covenant`.
All transaction outputs contain a
[value, an address, and a covenant.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/output.js#L255-L265)

### Covenants

The Handshake name auction system is run by transaction covenants. Currently all
[covenant types](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/rules.js#L43-L56)
operate on the naming system, but new covenants can be added that [don't affect
naming at all](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/covenant.js#L337-L350).
New covenant types can be added by
[soft fork](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/rules.js#L1365-L1370).

Covenants contain a [`type` and an array of items.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/covenant.js#L506-L519)
Items include auction details like a [name hash](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/wallet/wallet.js#L1536),
or a [blinded bid.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/wallet/wallet.js#L1672)

Name covenants are linked together in a chain, in the same way that transaction
inputs and outputs transfer value in a chain. In addition, some covenants must
identify the correct [name hash](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/rules.js#L1196)
to be valid. There are
[rules](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/rules.js#L1062)
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
[the second-highest bid.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/blockchain/chain.js#L1096-L1102)
In the event only one bid is submitted, that bidder can recover their entire bid
(when they `REGISTER`) in essence, paying the second-highest bid of zero.

Once a name has been registered it's value is locked forever, but the namestate
can still be changed.

#### These covenant types update "owned" names:

| From --> | --> To     | Purpose   |
|----------|------------|-----------|
| `REGISTER`, `UPDATE`, `RENEW`, `TRANSFER`, `FINALIZE` | `UPDATE` | _Update the DNS resource_ |
| `REGISTER`, `UPDATE`, `RENEW`, `TRANSFER`, `FINALIZE` | `RENEW` | _Renew name ownership before expiration_ |
| `REGISTER`, `UPDATE`, `RENEW`, `FINALIZE` | `TRANSFER` | _Initiate ownership transfer to new Handshake address_ |
| `TRANSFER` | `FINALIZE` | _Confirm ownership to new Handshake address_ |
| `REGISTER`, `UPDATE`, `RENEW`, `TRANSFER`, `FINALIZE`  | `REVOKE` | [_Permanently burn name._](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/rules.js#L1361-L1364) _Used when a key is compromised_ |

Transfers are locked for
[about two days](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L319)
before `FINALIZE` is allowed. At any point during that phase, the original owner can `REVOKE`.

Names must be renewed within
[two years](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L267)
or they become available for new auctions again.

When a name is updated with either `REGISTER` or `UPDATE`, the new resource
is stored in a
[temporary data structure in the chain database.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/blockchain/chaindb.js#L1848)
Every 36 blocks (about 6 hours) this cache is
[committed to the urkel tree](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/blockchain/chaindb.js#L1851-L1872).

From the [whitepaper](https://handshake.org/files/handshake.txt):

> Because our tree is implemented as a series of append-only files, a
> commission interval is required to prevent history bloat, which may otherwise
> require the user of the software to compact their history regularly.

### Auctions

Name auctions progress through a
[series of states based on time](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/namestate.js#L127-L159)
(i.e. block depth).
The first time a name is seen on chain, it's state is
[set to the current block height.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/blockchain/chain.js#L927)
This height is saved in the database and used as a reference point for the entire
auction process. It can be [reset](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/namestate.js#L229)
after a name expires. Covenant types will be rejected if they are broadcast during the
wrong phase.

| Blocks since<br>previous state   | Approx. time | Current state     |
|----------------------------------|--------------|-------------------|
| (undefined name)                 |              | `CLOSED`          |
| < 37                             | ~6 hours     | `OPEN`            |
| < 720                            | ~5 days      | `BIDDING`         |
| < 1,440                          | ~10 days     | `REVEAL`          |
| > 0                              |              | `CLOSED`          |

When reserved names are claimed on chain, they enter a
[lockup period of about 30 days](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L260).
During the `LOCKED` phase,
[a reserved name can be re-claimed](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/blockchain/chain.js#L944-L955).
This is to provide solutions to legacy DNS name holders whose keys are compromised.

### Claims

Legacy DNS names in the Alexa top 100,000 are reserved for their current owners.
You can see the list in [names.json](https://raw.githubusercontent.com/handshake-org/hsd/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/names.json).

[Learn more about the claims list.](https://github.com/handshake-org/hs-names)

[Learn about on-chain name claims.](https://handshake-org.github.io/guides/claims.html)

Claims are broadcast to the network in a special type of transaction message, and miners
[include the proofs in coinbase inputs](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/mining/template.js#L280-L306)

#### RSA-1024 Soft Fork

DNSSEC proofs can be signed with a variety of algorithms. Unfortunately, this includes
1024-bit RSA. Keys of that limited size may be compromised in the near future,
much like SHA-1 has already been. For this reason, Handshake is
[already prepared for a soft fork](https://github.com/handshake-org/hsd/blob/master/lib/blockchain/chain.js#L974-L983)
to prohibit claims of this nature. Names that have already been claimed with a weak
key will be
[prohibited from registering](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/blockchain/chain.js#L1181-L1195)
after the soft fork activates. Reserved names can be re-claimed
[any time before registration](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/blockchain/chain.js#L944-L955).

#### KSK-2010 Soft Fork

Currently the DNSSEC chain of signatures can be rooted by either one of ICANN's key-signing-keys:
KSK-2010, and KSK-2017. The older key
[has already been revoked](https://www.icann.org/news/blog/icann-is-revoking-the-old-key-signing-key-this-week)
and its use may be prohibited by the Handshake blockchain. Another
[soft fork is in place](https://github.com/handshake-org/hsd/blob/acd80f114f92e56fdf1c27f176bfde3ec25aabee/lib/blockchain/chain.js#L608-L616)
to prohibit use of KSK-2010 when the community agrees it is necessary.

### Name rollout

Un-reserved names are not all available immediately when mainnet launches. They
become available over the first year, based on a simple algorithm that
[compares the name's hash against a 52-week modulus.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/rules.js#L273-L295)

The RPC call [getnameinfo](https://handshake-org.github.io/api-docs/#getnameinfo)
will return the `week` value, indicating when a given name is available.

The entire Handshake auction system is not active until
[the first fourteen days](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L246)
of network life. In fact, transactions of any kinds are not allowed for the first
[fourteen days](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/protocol/networks.js#L231)
in order to accumulate a secure level of proof-of-work.

### Airdrop

Two thirds of the total currency supply is reserved for hundreds of thousands of
Internet citizens in the open-source software community. Public keys were collected
in various ways and added to a
[merkle tree](https://github.com/handshake-org/hs-tree-data),
whose root is
[committed](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/airdropproof.js#L27-L29)
in consensus code, and even referenced in the
[genesis block](https://github.com/handshake-org/hsd/blob/acd80f114f92e56fdf1c27f176bfde3ec25aabee/bin/genesis#L71).
Airdrops are redeemed by submitting a proof to the network.

Airdrop outputs ARE NOT included in the genesis block like other cryptocurrency
airdrops. A Handshake airdrop is like a transaction that can be submitted at any time.
Miners add the airdrop outputs to the coinbase transactions in new blocks, with the
proof encoded
[in the witness](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/mining/template.js#L308-L322)
of the corresponding input.

#### Airdrop proofs

Users who received an airdrop to a public key on an external platform can redeem it with a
[custom signing tool](https://github.com/handshake-org/hs-airdrop) that has a blinding factor
built in to conceal the identity of the recipient. Because users have a wide variety of
public key types, airdrop proofs are subject to the same
[RSA-1024 soft fork](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/blockchain/chain.js#L571-L584)
described above for name claims.

#### Faucet proofs

A portion of the airdrop was made available to users that signed up through a website
during 2018. These users generated a main net Handshake address with a
[faucet tool](https://github.com/handshake-org/faucet-tool)
and submitted it along with meta data. Because these airdrop recipients are recorded by address and not public key,
no signature is required to generate their airdrop transactions (of course a signature
is required to SPEND from the airdrop, like any other address). Because these transactions
can be generated and submitted by any node at any time, their
[fees are hard-coded, and enforced by consensus rules.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/airdropproof.js#L19-L20)

Airdrop double-redeems are prevented by a
[bitfield in the chain database.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/covenants/bitfield.js#L97-L126)

### Script OP Codes

Several new OP codes has been added to the redeem script language.

| Hex Code | Name | Operation                         |
|----------|------|-----------------------------------|
| `0xd0`   | `OP_TYPE`              | [_Get the covenant type (int) from the corresponding tx output and push on to stack_](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/script/script.js#L566-L580) |

This extra OP code was added to Handshake to make name updates and transfers
more secure. For example, a hot/cold wallet system could be implemented
in which "cold" keys handle name transfers but "hot" keys are used for DNS resource updates.

Handshake also implements
[four additional hash function OP codes.](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/script/script.js#L1073-L1100)
Each of these pop one item off the stack, and return the hash function digest
of that blob.

| Hex Code | Name          |
|----------|---------------|
| `0xc0`   | `OP_BLAKE160` |
| `0xc1`   | `OP_BLAKE256` |
| `0xc2`   | `OP_SHA3`     |
| `0xc3`   | `OP_KECCAK`   |


### SigHash types

Handshake implements two new sighash types. These can be used in more creative transactions
by signing a commit to different combinations of transaction elements.

[`SIGHASH_NOINPUT`](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/tx.js#L279-L280)
is defined in Bitcoin as [BIP 118](https://github.com/bitcoin/bips/blob/master/bip-0118.mediawiki),
and enables flexibility in off-chain and layer two protocols. It allows a TX to
spend from any output that "solves" the redeem script, instead of specifying
one single tx output by `txid` and `index`. It is implemented
[as a mask `0x40`](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/script/common.js#L422-L426),
so it can be combined with other SIGHASH flags like `SIGHASH_SINGLE`.

[`SIGHASH_SINGLEREVERSE`](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/primitives/tx.js#L343-L347)
allows for on-chain atomic sales of a name to a coin holder. A specially crafted
transaction can be generated by a name owner that commits to one input that signs for their name,
and one output that spends coins to their wallet. Another user can add one input that
funds the transaction, and the `TRANSFER` output to their own address. Note that
the buyer must require that the name-owning script checks `OP_TYPE` in such a way to prevent
the name owner from issuing a `REVOKE` before the `FINALIZE` can be issued.
This sighash type is implemented as
[`0x04`](https://github.com/handshake-org/hsd/blob/56c83ca7344def512ef861f452bff91d43bc8f52/lib/script/common.js#L413-L420).


