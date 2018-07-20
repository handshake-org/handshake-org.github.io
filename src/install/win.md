## Windows Install Guide
>NOTE: the software has not been thoroughly tested on Windows.

1. Install Some Software
- Node / NPM https://nodejs.org/en/download/
- OpenSSL Win 64 http://slproweb.com/products/Win32OpenSSL.html

2. Python and Windows Build Tools install
```
$ npm install --global --production windows-build-tools
$ npm config set msvs_version 2015 --global
```

3. Install Cygwin with the following instructions
- Download from https://cygwin.com/install.html
- Open command prompt by running ‘cmd’
- Run:
```
cd Downloads
setup-x86_64.exe ^
  --root C:\Cygwin64\ ^
  --site http://cygwin.mirror.constant.com ^
  --quiet-mode ^
  --no-desktop ^
  --packages wget,git,automake,autoconf,cygwin32-libtool,libunbound-common,libunbound-devel,libunbound2,nano,libtool,gcc-g++,cygwin32-gcc-g++,make
```
>Note: this assumes you use the C: drive

4. Set Cygwin Path
- Open command prompt (cmd)
- Set path:
```
$ set PATH=%PATH;C:\Cygwin64\bin
$ setx PATH %PATH;C:\Cygwin64\bin
```
>Note: or just Cygwin above if on 32bit machine

5. Run bash
```
$ bash
```

6. Go home
```
$ cd /home
```

7. Install `hskd`
- Start
```
$ git clone git@github.com:handshake-org/hskd.git
$ cd hskd
$ git clone git@github.com:handshake-org/hsk-client.git
$ cd hsk-client
$ npm install --production
$ cd ..
$ npm link hsk-client
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
- Go thru and edit package.json in root `hskd/` folder to use file: of the above.
- Edit binding.gyp: `"<!(bash -c \"python -c 'from __future__ import print_function; import sys; print(sys.byteorder)'\")",`
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
- Continue by going to root /hskd/ folder but make sure you edit package.json to do file: for the above modules.
```
$ npm install --production
$ cd ..
```

8. Exit bash and setup mklink
```
$ mklink /D C:\home C:\Cygwin64\home
```

9. Start `hskd` (in simnet) (open bash again)
```
# Start the full node in simnet
$ ./hskd/bin/hskd -n simnet --daemon --no-auth --coinbase-address=ss1qnwxzkgfymaz84k7wwf8v009nuqjf90vx2zfmts

# Mine two blocks to ensure the name trie is in the correct state
$ ./hskd/hsk-client/bin/hsk-cli -n simnet rpc generate 2
```

10. Install `hnsd`
```
$ git clone git@github.com:handshake-org/hnsd.git
$ cd hnsd
$ ./autogen.sh && ./configure --with-network simnet && make
```

11. Start `hnsd`
```
$ ./hnsd.exe --pool-size=1 --rs-host=127.0.0.1:53
```

12. Change Windows DNS Settings to point to 127.0.0.1

