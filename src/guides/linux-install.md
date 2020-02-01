# Linux Install Guide

The Handshake software suite consists of a full node (`hsd`) and a light
client (`hnsd`). The full node allows users to register, update, and transfer
names, resolve names, and make blockchain payments. The light client (SPV node)
allows users to resolve names without the computing resource requirements of
running a full node.

This guide includes instructions for installing
[`hsd`](#hsd-installation-instructions) and
[`hnsd`](#hnsd-installation-instructions).

> Note: the instructions are specifically for Debian/Ubuntu. Be sure to use the
proper package manager for your OS. The BSDs and Solaris have not been tested yet,
but should work in theory.

Check [the repository](https://github.com/handshake-org/hsd#install) for updates.

<br/>

## `hsd` Installation Instructions
#### Install dependencies
- node.js (>= v10)
- git
```
$ sudo apt install nodejs git
```

#### Download and install `hsd`
```
$ git clone https://github.com/handshake-org/hsd
$ cd hsd
$ npm install --production
```

#### Start (on mainnet)
```
$ ./bin/hsd
```

<br/>

## `hnsd` Installation Instructions
#### Install dependencies
```
$ sudo apt install automake autoconf libtool unbound libunbound-dev
```
>Note: unbound-devel in yum

#### Download and compile `hnsd`
```
git clone https://github.com/handshake-org/hnsd
cd hnsd
./autogen.sh && ./configure --with-network=main && make
```

#### Start `hnsd`
```
sudo setcap 'cap_net_bind_service=+ep' /path/to/hnsd
./hnsd --pool-size=1 --rs-host=127.0.0.1:53
```

#### Configure nameserver settings
1. resolv.conf
```
$ echo 'nameserver 127.0.0.1' | sudo tee /etc/resolv.conf > /dev/null
```

2. Edit resolvconf.conf to match:
```
name_servers="127.0.0.1"
```
