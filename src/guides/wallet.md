## Seting up a Handshake Wallet 


`hsd` offers a powerful, modular way to create and manage handshake wallets. In this guide, I'll walk you through the concepts and features you'll need to know about to get started.

### The Basics
If you're a seasoned bitcoiner, you can probably skim this section or skip straight ahead to the <a href='#examples'> Examples </a>section. But if you're relatively new or just want a refresher, this section will help you understand how wallets actually work.

### Wallets
In the most basic sense, a handshake wallet is data that enables you to receive and spend HNS, place bids on names and update resource records for your names. `hsd` implements the latest specifications for structuring wallets that are easy to backup, easy to restore, and that work just as well for a novice making their first transactions as for a business with millions of users.

### Keys to the Game
If you want to transact with HNS, you'll need keys. Each handshake address is associated with a particular key, and wallets are made up of many different keys. Keys consist of both a private key and a public key. The private key is required for spending and is extremely sensitive information, while a public key can be used to receive HNS  and monitor a particular address. If you want to learn more about how this works, read up on Public-Key Cryptography.

### HD vs. Non-HD, you mean like TVs?
You may have seen references to "HD" wallets and wondered what that means. HD in this context does not mean "high definition," as I assumed it did at first, but rather "hierarchical deterministic." An HD wallet takes a hierarchy of keys in order and makes it so any key in that sequence can be determined by the one before it. This means that if you can produce the first key in the hierarchy, you can then generate a practically unlimited number of subsequent keys. The specification for HD wallets as implemented in `hsd` is defined by [Bitcoin Improvement Proposal (BIP) 32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki).

Non-HD wallets, on the other hand, contain keys that are unrelated to one another. Backing up such a wallet means each key must be preserved individually. Not only is this more cumbersome, but it means that backups can quickly become out of date as new keys are added to the wallet. With an HD wallet, as long as you hold on to the seed - the data needed to recreate the first key - you will be able to recover every other key.

While `hsd` uses HD wallets, it does allow you to import individual keys into a wallet. This can be a handy feature in certain cases, but it means you'll need to backup any imported keys separately as they will not be recoverable simply by using your seed.

But what exactly is the seed for an HD wallet? It can come in several forms, but `hsd` implements [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) which enables seeds to be represented by a mnemonic made up of a fixed set of common words. This means your seed can be easily spoken, written down, or perhaps even memorized. But be careful! Your seed can be used to recover and spend everything in your HD wallet (except for the aforementioned imported keys), so treat it like you would an actual wallet with cash in it.

By default, mnemonics in hsd are made up of twelve words representing 128 bits of entropy. This is a common standard that is far and away beyond what cutting edge computers can hope to crack via brute force. But if you want additional entropy, `hsd` supports up to 512 bits of entropy which makes a 48 word mnemonic.

### Accounts
Wallets in `hsd` are partitioned into accounts. When you first create a wallet, a "default" account is created automatically along with it. Accounts can be used to track and manage separate sets of keys all within a single wallet. For example, a business can use accounts to generate distinct addresses for depositors or to segregate customer funds internally.

`hsd` implements [BIP44](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)  as a method of generating unlimited accounts deterministically. This adds additional dimensions to the hierarchy described above, meaning the same seed that can recover all your keys can also recover all your addresses.

Each account also comes with its own "extended public key," a piece of data that can be used to generate all public keys for that account in deterministic fashion. This means, for instance, that a business can create limitless deposit addresses for its users without having to touch its critical private keys or seed. Remember that public keys can be used for receiving HNS, but not for spending, so a public key falling into the wrong hands will not immediately result in theft.

### Watch Only Wallets
Speaking of not touching private keys, hsd gives you the option to create wallets that are "watch only." Watch only wallets don't contain any private keys, which means they can't be used to spend the HNS they receive. However, they work perfectly fine for creating addresses, receiving HNS, and detecting incoming transactions. Using watch only wallets where appropriate reduces the risk of your keys and HNS being stolen and is good security practice.

Accounts always inherit the watch only behavior of their parent wallet. In other words, a watch only wallet will have exclusively watch only accounts while a regular wallet will have only regular accounts. Accordingly, you can't import private keys into a watch only wallet or public keys into regular wallets. If you try to mix and match watch only wallets and keys with hsd, you're gonna have a bad time.


### API Authentication
`hsd` runs as a server and allow you to interact with your wallets via a REST API. It also allows you protect wallets from unauthenticated requests by running the server with the wallet-auth option. Each wallet you create has a token value that must be passed in with each request. Tokens, like accounts and keys, can also be deterministically generated using your HD seed. This means you can change the token on a wallet as often as you'd like.

### Recovery
By using the HD standards mentioned above, hsd allows one to easily restore or transfer their entire wallet to different wallet implementations. By providing just the mnemonic, one can fully recover their wallet to a fresh instance of `hsd` or any other software that properly implements BIP33, BIP39, and BIP44, like the Trezor hardware wallet.

*Above borrowed from [Wallets and Accounts and Keys, Oh My!](https://bcoin.io/guides/wallets.html) by Daniel McNally*
&nbsp;\
&nbsp;\

<h2 id='examples'>Examples</h2>

Command line examples against a local `hsd` server.

To begin, install [hsd]([https://handshake-org.github.io/) and [hs-client](https://github.com/handshake-org/hs-client)
&nbsp;\
&nbsp;\

### hs-client: Interact with your wallet

`hs-client` comes with four executables. For the Wallet you will want to use `hsw-cli` and `hsw-rpc`.
&nbsp;\

* `hsw-cli` - Wallet REST API
&nbsp;\

* `hsw-rpc` - Wallet RPC interface 
&nbsp;\

* `hsd-rpc`  - hsd node RPC interface
&nbsp;\

* `hsd-cli` - hsd node REST API
&nbsp;\


For more info on node commands unrelated to the wallet. [See here](https://handshake-org.github.io/api-docs))

Below you will find short intros to both wallet tools `hsw-cli` and `hsw-rpc` Use them for wallet creation, sending coins, generating addresses, bidding on names, updating resource records for a name, transfering names, etc.. 
&nbsp;\


### Set the network option

You have four choices to chose when setting your `hsd` node's network. The `hs-client` CLI tools also require this option be set for them to know the port with which to connect to your `hsd` node.

* `regtest` Best for local development work.
* `testnet` Closest simulation to mainnet. Supported by a network of nodes run by other devs.
* `mainnet` Live production.

You can set the network for your hsd node with the `--network=` option. Or with `$ export HSD_NETWORK=` 
Choose 'regtest' for testing out the commands below.


### hsw-cli

&nbsp;\
Create a new wallet and encrypt it with a passphrase 
``` bash
$ hsw-cli mkwallet mynewwallet --passphrase=supersecret
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
$ hsw-cli balance --id=mynewwallet --token=aef7603ff78c32e267fad434246ce6447d420b81e4798d99cf06c80b57c40765
```

&nbsp;\
Generate a new receiving address for an account
``` bash
$ hsw-cli --id=$name-of-wallet --accout=$name-of-account address
```

&nbsp;\
Get the HNS balance of your wallet
``` bash
$ hsw-cli --id=balance
```

&nbsp;\
List all wallets in your walletdb.
``` bash
$ hsw-cli wallets
```

&nbsp;\
Send HNS coins to an address
``` bash
$ hsw-cli send 
```
&nbsp;\

### hsw-rpc
Handshake Name specific functionality

&nbsp;\
Get info on the names your wallet is watching
``` bash
$ hsw-rpc getnames
```
&nbsp;\

NOTE: This is a very simplified guide. For more features, such as importing an existing mnemonic key, consult the full documentation.

[Complete documentation of the Wallet API](https://handshake-org.github.io/api-docs/#wallet)




