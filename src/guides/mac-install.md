# macOS Install Guide

The Handshake software suite consists of a full node (`hsd`) and a light
client (`hnsd`). The full node allows users to register, update, and transfer
names, resolve names, and make blockchain payments. The light client (SPV node)
allows users to resolve names without the computing resource requirements of
running a full node.

This guide includes instructions for installing
[`hsd`](#hsd-installation-instructions) and
[`hnsd`](#hnsd-installation-instructions).

Check [the repository](https://github.com/handshake-org/hsd#install) for updates.

<br/>

## `hsd` Installation Instructions
#### Install dependencies
Xcode Command Line Tools, Homebrew, node.js (>= v10) & git
```bash
$ xcode-select --install
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install node git
```

#### Download and install `hsd`
```bash
$ git clone git@github.com:handshake-org/hsd.git
$ cd hsd
$ npm install --production
```

#### Start (on testnet)
```bash
$ ./hsd/bin/hsd --daemon --no-auth
```

<br/>

## `hnsd` Installation Instructions
#### Install dependencies
```bash
$ brew install git automake autoconf libtool unbound
```

#### Download and compile `hnsd`
```bash
$ git clone git@github.com:handshake-org/hnsd.git
$ cd hnsd
$ ./autogen.sh && ./configure --with-network=testnet && make
```

#### Start `hnsd`
```bash
$ sudo ./hnsd --pool-size=1 --rs-host=127.0.0.1:53
```

#### Configure nameserver settings
- Open "System Preferences" on the panel/dock.
- Select "Network".
- Select "Advanced".
- Select "DNS".
- Remove all nameservers and add a single server: "127.0.0.1".
