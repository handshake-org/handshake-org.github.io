## Windows Install Guide

The Handshake software suite consists of a full node (`hsd`) and a light
client (`hnsd`). The full node allows users to register, update, and transfer
names, resolve names, and make blockchain payments. The light client (SPV node)
allows users to resolve names without the computing resource requirements of
running a full node.

This guide includes instructions for installing
[`hsd`](#hsd-installation-instructions) and
[`hnsd`](#hnsd-installation-instructions).

>NOTE: the software has not been thoroughly tested on Windows.

<br/>

## `hsd` Installation Instructions
#### Install dependencies
- Node / NPM [https://nodejs.org/en/download/](https://nodejs.org/en/download/)
- OpenSSL Win 64 [http://slproweb.com/products/Win32OpenSSL.html](http://slproweb.com/products/Win32OpenSSL.html)

Python and Windows Build Tools install:
```bash
$ npm install --global --production windows-build-tools
$ npm config set msvs_version 2015 --global
```

Cygwin

- Download from [https://cygwin.com/install.html](https://cygwin.com/install.html)
- Open command prompt by running ‘cmd’
- Run:
```bash
cd Downloads
setup-x86_64.exe ^
  --root C:\Cygwin64\ ^
  --site http://cygwin.mirror.constant.com ^
  --quiet-mode ^
  --no-desktop ^
  --packages wget,git,automake,autoconf,cygwin32-libtool,libunbound-common,libunbound-devel,libunbound2,nano,libtool,gcc-g++,cygwin32-gcc-g++,make
```
>Note: this assumes you use the C: drive

#### Set Cygwin Path
- Open command prompt (cmd)
- Set path:
```bash
$ set PATH=%PATH;C:\Cygwin64\bin
$ setx PATH %PATH;C:\Cygwin64\bin
```
>Note: if on 32bit machine, just Cygwin above

#### Run bash
```bash
$ bash
```

#### Change to home directory
```bash
$ cd /home
```

#### Download and install `hsd`
```
$ git clone git@github.com:handshake-org/hsd.git
$ cd hsd
$ npm pack bsip
$ npm pack mrmr
$ npm pack bcrypto
$ tar -zvxf mrmr*
$ mv package mrmr
$ tar -zxvf bcrypto*
$ mv package bcrypto
$ tar -zxvf bsip*
$ mv package bsip
$ rm *.tgz
$ cd bcrypto
```
- Go thru and edit package.json in root `hsd/` folder to use file: of the above.
- Edit binding.gyp: `"<!(bash -c \"python -c \"from __future__ import print_function; import sys; print(sys.byteorder)\"\")",`
- Continue
```
$ cd ..
$ cd bsip
```
- Do same to binding.gyp
- Continue
```
$ cd ..
$ cd bstring
```
- Do same to binding.gyp
- Continue
```
$ cd ..
$ cd bcrypto
$ cd src
$ cd chacha20
$ mv chacha20.c chacha20_2.c
$ mv chacha20.h chacha20_2.h
```
- Replace chacha20.h reference in chacha20_2.c to chacha20_2.h
- Continue
```
$ cd ..
```
- Replace chacha20.h reference in chacha20.h to chacha20_2.h and crypt_scrypt.c also needs to change sha256_2.h
- Continue
```
$ cd ..
```
- Replace reference to chacha20/chacha20.c to chacha20/chacha20_2.c in binding.gyp
- Do the same for blake2b
- Do the same for sha256 (note: It’s only in binding.gyp and not in the src/sha256.h)
- Continue by going to root /hsd/ folder but make sure you edit package.json to do file: for the above modules.
```
$ npm install --production
$ cd ..
```

#### Exit bash and setup mklink
```
$ mklink /D C:\home C:\Cygwin64\home
```

#### open bash again and Start (on testnet)
```bash
$ ./hsd/bin/hsd --daemon --no-auth
```

<br/>

## `hnsd` Installation Instructions
#### Download and compile `hnsd`
```bash
$ git clone git@github.com:handshake-org/hnsd.git
$ cd hnsd
$ ./autogen.sh && ./configure --with-network testnet && make
```

#### Start `hnsd`
```
$ ./hnsd.exe --pool-size=1 --rs-host=127.0.0.1:53
```

#### Change Windows DNS Settings to point to 127.0.0.1
