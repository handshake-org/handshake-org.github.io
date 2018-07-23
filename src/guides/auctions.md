## How to Participate in a Name Auction

First we should look at the current status of a name we want.

``` bash
$ hsk-cli rpc getnameinfo handshake
```

Once we know the name is available, we can send an "open transaction", this is
necessary to start the bidding process. After an open transaction is mined,
there is a short delay before bidding begins. This delay is necessary to ensure
the auction's state is inserted into the [urkel] tree.

``` bash
# Attempt to open bidding for `handshake`.
$ hwallet-cli rpc sendopen handshake
```

Using `getnameinfo` we can check to see when bidding will begin. Once the
auction enters the bidding state, we can send a bid, with a lockup-value to
conceal our true bid.

``` bash
# Send a bid of 5 coins, with a lockup value of 10 coins.
# These units are in HNS (1 HNS = 1,000,000 dollarydoos).
$ hwallet-cli rpc sendbid handshake 5 10
```

After the appropriate amount of time has passed, (1 day in the case of
testnet), we should reveal our bid.

``` bash
# Reveal our bid for `handshake`.
$ hwallet-cli rpc sendreveal handshake
```

We can continue monitoring the status, now with the wallet's version of
getnameinfo:

``` bash
$ hwallet-cli rpc getnameinfo handshake
# To see other bids and reveals
$ hwallet-cli rpc getauctioninfo handshake
```

If we end up losing, we can redeem our money from the covenant with
`$ hwallet-cli rpc sendredeem handshake`.

If we won, we can now register and update the name using `sendupdate`.

``` bash
$ hwallet-cli rpc sendupdate handshake \
  '{"ttl":172800,"ns":["ns1.example.com.@1.2.3.4"]}'
```

Note that the `ns` field's `domain@ip` format symbolizes glue.

Expiration on testnet is around 30 days, so be sure to send a renewal soon!

``` bash
$ hwallet-cli rpc sendrenewal handshake
```
