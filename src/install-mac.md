## macOS Install Guide

1. Open Terminal.App

2. Install Xcode Command Line Tools
```
$ xcode-select --install
```

3. Install Homebrew and npm
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install npm
```

4. Install `hskd`
```
$ git clone git@github.com:handshake-org/hskd.git
$ cd hskd
$ git clone git@github.com:handshake-org/hsk-client.git
$ cd hsk-client
$ npm install --production
$ cd ..
$ npm link hsk-client
$ npm install --production
$ cd ..
```

5. Start `hskd` (in simnet)
```
# Start the full node in simnet
$ ./hskd/bin/hskd -n simnet --daemon --no-auth --coinbase-address=ss1qnwxzkgfymaz84k7wwf8v009nuqjf90vx2zfmts

# Mine two blocks to ensure the name trie is in the correct state
$ ./hskd/hsk-client/bin/hsk-cli -n simnet rpc generate 2
```

6. Install Dependencies for hnsd
```
$ brew install git automake autoconf libtool unbound

# If something breaks, create folder that wasn’t created.
$ mkdir /usr/local/sbin && chmod `whoami`:admin /usr/local/sbin && chmod 0775 /usr/local/sbin
```

7. Install `hnsd`
```
$ git clone git@github.com:handshake-org/hnsd.git
$ cd hnsd
$ ./autogen.sh && ./configure --with-network=simnet && make
```

8. Start `hnsd`
```
$ sudo ./hnsd --pool-size=1 --rs-host=127.0.0.1:53 
```

9. Add `hnsd` to your default nameserver settings
- Open "System Preferences" on the panel/dock.
- Select "Network".
- Select "Advanced".
- Select "DNS".
- Remove all nameservers and add a single server: "127.0.0.1".

