# macOS Install Guide

The Handshake software suite consists of a full node (`hskd`) and a light
client (`hnsd`). The full node allows users to register, update, and transfer
names, resolve names, and make blockchain payments. The light client (SPV node)
allows users to resolve names without the computing resource requirements of
running a full node.

This guide includes instructions for installing
[`hskd`](#hskd-installation-instructions) and
[`hnsd`](#hnsd-installation-instructions).

<br/>

## `hskd` Installation Instructions
#### Install dependencies
Xcode Command Line Tools, Homebrew, node.js & git
```bash
$ xcode-select --install
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install node git
```

#### Download and install `hskd`
```bash
$ git clone git@github.com:handshake-org/hskd.git
$ cd hskd
$ npm install --production
```

#### Start (on testnet)
```bash
$ ./hskd/bin/hskd --daemon --no-auth
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
