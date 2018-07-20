## Linux Install Guide
> Note: these intructions are specifically for Debian/Ubuntu. Be sure to use the
proper package manager for your OS. Also, the BSDs and Solaris have also not
been tested yet, but should work in theory.

1. Install git and npm
```
$ sudo apt install npm git
```

2. Install `hskd`
```
$ git clone git@github.com:handshake-org/hskd.git
$ cd hskd
$ git clone git@github.com:handshake-org/hsk-client.git
$ cd hsk-client
$ npm install --production
$ cd ..
$ sudo npm link hsk-client
$ sudo chown -R `whoami`:`whoami` node_modules
$ npm install --production
$ cd ..
```

3. Start `hskd` (in simnet)
```
# Start the full node in simnet
$ ./hskd/bin/hskd -n simnet --daemon --no-auth --coinbase-address=ss1qnwxzkgfymaz84k7wwf8v009nuqjf90vx2zfmts

# Mine two blocks to ensure the name trie is in the correct state
$ ./hskd/hsk-client/bin/hsk-cli -n simnet rpc generate 2
```

4. Install dependencies for `hnsd`
```
$ sudo apt install automake autoconf libtool unbound libunbound-dev
```
>Note: unbound-devel in yum

5. Install `hnsd`
```
git clone git@github.com:handshake-org/hnsd.git
cd hnsd
./autogen.sh && ./configure --with-network && make
```

6. Start `hnsd`
```
sudo setcap 'cap_net_bind_service=+ep' /path/to/hnsd
./hnsd --pool-size=1 --rs-host=127.0.0.1:53 
```

7. Configure nameserver

  a. resolv.conf
  ```
  $ echo 'nameserver 127.0.0.1' | sudo tee /etc/resolv.conf > /dev/null
  ```

  b. Edit resolvconf.conf to match:
  ```
  name_servers="127.0.0.1"
  ```
