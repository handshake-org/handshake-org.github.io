## Setting Up Your Handshake Wallet 

Ready to create your first Handshake wallet?

To send and recieve HNS coins, you need an address. In Handshake, addresses belong to accounts which belong to  wallets. 

``` bash
wallet -> account -> address
```

Wallets are created through the hsd Wallet API.

Start by installing running hsd locally. [Go here for Installation instructions]([https://handshake-org.github.io/).

Then download and install [hs-client](https://github.com/handshake-org/hs-client) to begin interacting with the wallet API of your hsd node.

### hsw-cli

Once installed, the hsw-cli executable contained in hs-client is the best way to interact with the hsd Wallet API. Here are some common and helpful commands to get you started.

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


You are now ready to start sending and receiving HNS using hs-client. 

For complete documentation of the Wallet API, go here
https://handshake-org.github.io/api-docs/#wallet

NOTE: This is a very simplified guide. For more features, such as importing an existing mnemonic key, consult the full documentation.


