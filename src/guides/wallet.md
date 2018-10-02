## Setting Up Your Handshake Wallet 

To send and recieve HNS coins, bid on names and win auctions, you will need a wallet. In Handshake, addresses belong to accounts which belong to wallets (wallet -> account -> address), all of which are stored in the walletdb of your hsd node. `hsd` comes with a "primary" wallet and "default" account. Using the hs-client tool you can make and customize many more.

To begin, install [hsd]([https://handshake-org.github.io/) and [hs-client](https://github.com/handshake-org/hs-client)

### hs-client (hsw-cli & hsw-rpc)
`hs-client` comes with several executables, each supporting a different set of functionality. For the Wallet you will want to use `hsw-cli` and `hsw-rpc`. They are enerally split between the 'basic bitcoin-like' `hsw-cli` which contains all functionality common to bitcoin (wallet creation, sending coins, generating addresses, etc) and the Handshake-specific `hsw-rpc` (bidding on names, updating resource records for a name, transfering names, etc).

Below you will find short intros to both tools.


### hsw-cli
Basic bitcoin-like wallet features

Create a new wallet and encrypt it with a passphrase 
``` bash
$ hsw-cli mkwallet $name-of-wallet --passphrase=$your-passphrase
```

Create a new account in your wallet (this outputs the first sending and receiving addresses)
``` bash
$ hsw-cli --id=$name-of-wallet account create $name-of-account
```

Generate a new receiving address for an account
``` bash
$ hsw-cli --id=$name-of-wallet --accout=$name-of-account address
```

Get the HNS balance of your wallet
``` bash
$ hsw-cli balance
```

List all wallets in your walletdb.
``` bash
$ hsw-cli wallets
```

Send HNS coins to an address
``` bash
$ hsw-cli send 
```

### hsw-rpc
Handshake Name specific functionality

Get info on the names your wallet is watching
``` bash
$ hsw-rpc getnames
```

Start bidding process on a name
``` bash
$ hsw-rpc sendopen
```

Update resource records for a name
``` bash
$ hsw-rpc sendupdate clevertld '{"ttl":172800,"ns":["ns1.example.com.@1.2.3.4"]}'
```


Once are comfortable sending and receiving HNS, querying for nameinfo and auctionstatus, you are ready to bid on a name.

[How to bid on names](https://handshake-org.github.io/guides/auctions.html)

[Complete documentation of the Wallet API](https://handshake-org.github.io/api-docs/#wallet)

NOTE: This is a very simplified guide. For more features, such as importing an existing mnemonic key, consult the full documentation.


