## Setting up a Handshake Wallet 

*This guide is heavily copied from [Wallets and Accounts and Keys, Oh My!](https://bcoin.io/guides/wallets.html)
by Daniel McNally with edits specific to Handshake.*

If you're a seasoned bitcoiner, you can probably skim this section or skip
straight ahead to the <a href='#examples'> Examples </a>section. Or if you
already have a wallet and are looking to buy and manage names on Handshake
check out the [Name Auctions Guide](/guides/auctions.html).

But if you're relatively new or just want a refresher, this section will
help you understand how wallets actually work.

## The Basics
`hsd` offers a powerful, modular way to create and manage handshake wallets.
In this guide, I'll walk you through the concepts and features you'll need to
know about to get started.

### Wallets
In the most basic sense, a handshake wallet is data that enables you to
receive and spend HNS, place bids on names and update resource records for
your names. `hsd` implements the latest specifications for structuring wallets
that are easy to backup, easy to restore, and that work just as well for a
novice making their first transactions as for a business with millions of users.

### Keys to the Game
If you want to transact with HNS, you'll need keys. Each handshake address is
associated with a particular key, and wallets are made up of many different
keys. Keys consist of both a private key and a public key. The private key is
required for spending and is extremely sensitive information, while a public
key can be used to receive HNS and monitor a particular address. If you want to
learn more about how this works, read up on Public-Key Cryptography.

### HD Wallets
`hsd` supports "Hierarchical Deterministic" (HD) wallets. An HD wallet creates
a tree of keys ordered deterministically beginning from a single seed. An HD
wallet can generate a practically unlimited number of subsequent keys. The HD
Wallets in `hsd` implement
[BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki) and
create new accounts deterministically as specified in
[BIP44](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki).

While `hsd` uses HD wallets, it does allow you to import individual keys into
a wallet. This can be a handy feature in certain cases, but it means you'll
need to backup any imported keys separately as they will not be recoverable
simply by using your seed.

What is the seed for an HD wallet? It can come in several forms, but `hsd`
implements
[BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) which
enables seeds to be represented by a mnemonic made up of a fixed set of common
words. This means your seed can be easily spoken, written down, or perhaps even
memorized. But be careful! Your seed can be used to recover and spend everything
in your HD wallet (except for the aforementioned imported keys), so treat it
like you would an actual wallet with cash in it.

To securely generate a menmonic seed, Handshake provides
[this tool](https://github.com/handshake-org/faucet-tool)
for use on an air-gapped machine.

### Accounts
Wallets in `hsd` are partitioned into accounts. When you first create a wallet,
a "default" account is created automatically along with it. Accounts can be
used to track and manage separate sets of keys all within a single wallet.
For example, a business can use accounts to generate distinct addresses for
depositors or to segregate customer funds internally.

`hsd` implements
[BIP44](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)  as a
method of generating unlimited accounts deterministically. This adds additional
dimensions to the hierarchy described above, meaning the same seed that can
recover all your keys can also recover all your addresses.

Each account also comes with its own "extended public key," a piece of data
that can be used to generate all public keys for that account in deterministic
fashion. This means, for instance, that a business can create limitless deposit
addresses for its users without having to touch its critical private keys or
seed. Remember that public keys can be used for receiving HNS, but not for
spending, so a public key falling into the wrong hands will not immediately
result in theft.

### Watch Only Wallets
Speaking of not touching private keys, hsd gives you the option to create
wallets that are "watch only." Watch only wallets don't contain any private
keys, which means they can't be used to spend the HNS they receive.
However, they work perfectly fine for creating addresses, receiving HNS,
and detecting incoming transactions. Using watch only wallets where
appropriate reduces the risk of your keys and HNS being stolen and is good
security practice.

Accounts always inherit the watch only behavior of their parent wallet.
In other words, a watch only wallet will have exclusively watch only accounts
while a regular wallet will have only regular accounts. Accordingly, you can't
import private keys into a watch only wallet or public keys into regular
wallets. If you try to mix and match watch only wallets and keys with hsd,
you're gonna have a bad time.

### API Authentication
`hsd` runs as a server and allow you to interact with your wallets via a REST
API. It also allows you protect wallets from unauthenticated requests by
running the server with the wallet-auth option. Each wallet you create has a
token value that must be passed in with each request. Tokens, like accounts
and keys, can also be deterministically generated using your HD seed.
This means you can change the token on a wallet as often as you'd like.

### Recovery
By using the HD standards mentioned above, hsd allows one to easily restore
or transfer their entire wallet to different wallet implementations.
By providing just the mnemonic, one can fully recover their wallet to a fresh
instance of `hsd` or any other software that properly implements BIP33, BIP39,
and BIP44 and supports Handshake.
&nbsp;\
&nbsp;\

### Graphical Interface
There is a third party GUI [Bob wallet](https://github.com/kyokan/bob-wallet).

<h2 id='examples'>Examples</h2>

Command line examples against a local `hsd` server.

To begin, install [hsd](https://github.com/handshake-org/hsd) and
[hs-client](https://github.com/handshake-org/hs-client)
&nbsp;\

### hs-client: Interact with your wallet

`hs-client` comes with four executables. For the Wallet you will want to use
`hsw-cli` and `hsw-rpc`.
&nbsp;\

* `hsw-cli` - Wallet REST API
&nbsp;\

* `hsw-rpc` - Wallet RPC interface 
&nbsp;\

* `hsd-rpc`  - hsd node RPC interface
&nbsp;\

* `hsd-cli` - hsd node REST API
&nbsp;\

For more general info on hsd,
[see here](https://hsd-dev.org/api-docs/#introduction).

For more general info on the wallet,
[see here](https://hsd-dev.org/api-docs/#wallet).

Below you will find short intros to both wallet tools `hsw-cli` and `hsw-rpc`.
Use them for wallet creation, sending coins, generating addresses, bidding on
names, updating resource records for a name, transfering names, etc.. 
&nbsp;\

### Set the network option

You have four choices when setting your `hsd` node's network. The `hs-client`
CLI tools also require this option be set for them to know the port with which
to connect to your `hsd` node.

* `regtest` For local development work.
* `simnet` For testing your own network.
* `testnet` Closest simulation to mainnet. Supported by a network of nodes
   run by other devs.
* `mainnet` Live production.

You can set the network for your hsd node with the `--network=` option or by
setting the environment variable `HSD_NETWORK`. Choose 'regtest' for testing
out the commands below.

### hsw-cli

&nbsp;\
Calling the CLI without any arguments `$ hsw-cli` will output the list of
supported commands. There are also admin commands that can be viewed by
running `$hsw-cli admin.`

&nbsp;\
Create a new wallet, seed it with a mnemonic phrase, and encrypt it with
a passphrase.
``` bash
$ hsw-cli mkwallet <wallet-id> --mnemonic=<mnemonic-phrase> --passphrase=<passphrase>
```

Response JSON:
``` json
{
  "network": "regtest",
  "wid": 3,
  "id": "ha",
  "watchOnly": false,
  "accountDepth": 1,
  "token": "aef7603ff78c32e267fad434246ce6447d420b81e4798d99cf06c80b57c40765",
  "tokenDepth": 0,
  "master": {
    "encrypted": false
  },
}
```

&nbsp;\
See that `token`? With it we can do things like query our wallet balance
``` bash
$ hsw-cli balance --id=<wallet-id> --token=aef7603ff78c32e267fad434246ce6447d420b81e4798d99cf06c80b57c40765
```

&nbsp;\
Create a new account
``` bash
$ hsw-cli --id=<wallet-id> account create <name-of-new-account>
```

&nbsp;\
Generate a new receiving address for an account
``` bash
$ hsw-cli --id=<wallet-id> --account=<name-of-account> address
```

&nbsp;\
Get the HNS balance of your wallet
``` bash
$ hsw-cli --id=<wallet-id> balance
```

&nbsp;\
List all wallets in your walletdb.
``` bash
$ hsw-cli wallets
```

&nbsp;\
List all accounts in a given wallet
``` bash
$ hsw-cli --id=<wallet-id> account list
```

&nbsp;\
Send HNS coins to an address

*Be careful how you enter values and fee rates! Value and rate are expressed
in dollarydoos when using cURL or Javascript. Value and rate are expressed in
WHOLE HNS  when using CLI. Watch carefully how values are entered in the
examples, all examples send the same amount when executed.*

``` bash
$ hsw-cli send --id=<wallet-id> --value=<number of WHOLE HNS> --address=<destination address> --passphrase=<passphrase>
```

&nbsp;\
Initiate blockchain rescan for walletdb. Necessary after importing a key or wallet.
Wallets will be rolled back to the specified block height if provided.
``` bash
$ hsw-cli rescan --height=<block-height>
```

### hsw-rpc

&nbsp;\
Get info on all of the names your wallet has interacted with (open, bid, reveal, etc).
``` bash
$ hsw-rpc getnames
```

&nbsp;\
Get info on a wallet.
``` base
$ hsw-rpc --id=<wallet-id> getwalletinfo
```

&nbsp;\
Get resource data for a name
``` base
$ hsw-rpc getnameresource <name>
```


Response JSON
``` json
{
  "walletid": "primary",
  "walletversion": 6,
  "balance": 390005.02398,
  "unconfirmed_balance": 390005.02398,
  "txcount": 450,
  "keypoololdest": 0,
  "keypoolsize": 0,
  "unlocked_until": 0,
  "paytxfee": 0
}
```
&nbsp;\

NOTE: This is a very simplified guide. For more features, such as creating claims,
signing transactions and more, consult the full documentation.

[Complete documentation of the Wallet API](https://handshake-org.github.io/api-docs/#wallet)
