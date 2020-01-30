## How to Participate in a Name Auction

First we should look at the current status of a name we want.

``` bash
$ hsd-cli rpc getnameinfo handshake
```

Once we know the name is available, we can send an "open transaction", this is
necessary to start the bidding process. After an open transaction is mined,
there is a short delay before bidding begins. This delay is necessary to ensure
the auction's state is inserted into the [urkel] tree.

``` bash
# Attempt to open bidding for `handshake`.
$ hsw-cli rpc sendopen handshake
```

Using `getnameinfo` we can check to see when bidding will begin. Once the
auction enters the bidding state, we can send a bid, with a lockup-value to
conceal our true bid.

``` bash
# Send a bid of 5 coins, with a lockup value of 10 coins.
# These units are in HNS (1 HNS = 1,000,000 dollarydoos).
$ hsw-cli rpc sendbid handshake 5 10
```

After the appropriate amount of time has passed, (1 day in the case of
testnet), we should reveal our bid.

``` bash
# Reveal our bid for `handshake`.
$ hsw-cli rpc sendreveal handshake
```

We can continue monitoring the status, now with the wallet's version of
getnameinfo:

``` bash
$ hsw-cli rpc getnameinfo handshake
# To see other bids and reveals
$ hsw-cli rpc getauctioninfo handshake
```

If we end up losing, we can redeem our money from the covenant.

```
$ hsw-cli rpc sendredeem handshake
```

If we won, we can now register and update the name using `sendupdate`.

``` bash
$ hsw-cli rpc sendupdate handshake \
 '{"records": [{"type": "GLUE4", "ns": "ns1.handshake.", "address": "1.2.3.4"}]}'
```

Formatting examples for each record type are
[listed here.](https://github.com/handshake-org/hsd/blob/6afb72bb42cb05d52835eb36bf8ae3f9fbf9f3e0/test/resource-test.js#L9-L46)

Renewals on mainnet are required within about two years!

``` bash
$ hsw-cli rpc sendrenewal handshake
```
