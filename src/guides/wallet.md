## Set up a Handshake Wallet 

To send and recieve HNS coins, bid on names and win auctions, you will need a wallet. `hsd` supports HD (BIP32) wallets. Each wallet can contain many accounts each of which can have many addresses.

```
wallet -> accounts -> addresses
```

This is stored in the walletdb of your hsd node. `hsd` comes with a "primary" wallet and "default" account. Use the hs-client tool to interact with the Wallet API of `hsd`.


To begin, install [hsd]([https://handshake-org.github.io/) and [hs-client](https://github.com/handshake-org/hs-client)
&nbsp;\
&nbsp;\

### hs-client: Interact with your wallet

`hs-client` comes with four executables. For the Wallet you will want to use `hsw-cli` and `hsw-rpc`.
&nbsp;\
&nbsp;\

* `hsw-cli` - features common to bcoin;  wallet creation, sending coins, generating addresses, etc.
&nbsp;\
&nbsp;\

* `hsw-rpc` - features specific to Handshake; bidding on names, updating resource records for a name, transfering names, etc.. 
&nbsp;\
&nbsp;\

Currently all naming-related functionality is only supported by the RPC interface.
(hsd-rpc and hsd-cli support node management commands unrelated to the wallet. [See more here](https://handshake-org.github.io/api-docs))
Below you will find short intros to both wallet tools.
&nbsp;\

### hsw-cli
Basic bitcoin-like wallet features

&nbsp;\
Create a new wallet and encrypt it with a passphrase 
``` bash
$ hsw-cli mkwallet $name-of-wallet --passphrase=$your-passphrase
```

&nbsp;\
Create a new account in your wallet (this outputs the first sending and receiving addresses)
``` bash
$ hsw-cli --id=$name-of-wallet account create $name-of-account
```

&nbsp;\
Generate a new receiving address for an account
``` bash
$ hsw-cli --id=$name-of-wallet --accout=$name-of-account address
```

&nbsp;\
Get the HNS balance of your wallet
``` bash
$ hsw-cli balance
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
Start bidding process on a name
``` bash
$ hsw-rpc sendopen
```

&nbsp;\
Update resource records for a name
``` bash
$ hsw-rpc sendupdate clevertld '{"ttl":172800,"ns":["ns1.example.com.@1.2.3.4"]}'
```

&nbsp;\
Once are comfortable sending and receiving HNS, querying for nameinfo and auctionstatus, you are ready to bid on a name.

[How to bid on names](https://handshake-org.github.io/guides/auctions.html)

[Complete documentation of the Wallet API](https://handshake-org.github.io/api-docs/#wallet)

NOTE: This is a very simplified guide. For more features, such as importing an existing mnemonic key, consult the full documentation.


