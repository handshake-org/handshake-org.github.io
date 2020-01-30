## Guía de instalación en Windows

El conjunto de software Handshake consta de un nodo completo (`hsd`) y un cliente ligero (`hnsd`). El nodo completo permite a los usuarios registrar, actualizar y transferir nombres, resolver nombres y realizar pagos en la cadena de bloques. El cliente ligero (nodo SPV) permite a los usuarios resolver nombres sin los requisitos de recursos informáticos de ejecutar un nodo completo.

Esta guía incluye instrucciones para instalar
[`hsd`](#hsd-installation-instructions) y
[`hnsd`](#hnsd-installation-instructions).

>NOTA: El software no ha sido probado a fondo en windows.

Consulte [el repositorio](https://github.com/handshake-org/hsd#install) para obtener actualizaciones.

<br/>

## instrucciones para la instalación de `hsd`
#### Instalamos dependencias
- Node.js (>= v10) / NPM [https://nodejs.org/en/download/](https://nodejs.org/en/download/)
- OpenSSL Win 64 [http://slproweb.com/products/Win32OpenSSL.html](http://slproweb.com/products/Win32OpenSSL.html)

Instalacion de Python y las herramientas de creación para windows :
```bash
$ npm install --global --production windows-build-tools
$ npm config set msvs_version 2015 --global
```

Cygwin

- Descarga de [https://cygwin.com/install.html](https://cygwin.com/install.html)
- Abre la línea de comandos ejecutando ‘cmd’
- Ejecuta:
```bash
cd Downloads
setup-x86_64.exe ^
  --root C:\Cygwin64\ ^
  --site http://cygwin.mirror.constant.com ^
  --quiet-mode ^
  --no-desktop ^
  --packages wget,git,automake,autoconf,cygwin32-libtool,libunbound-common,libunbound-devel,libunbound2,nano,libtool,gcc-g++,cygwin32-gcc-g++,make
```
>Nota: Esto asume que estas usando el disco C:

#### Asigna Cygwin al Path
- Abre una línea de comandos (cmd)
- Asigna el path:
```bash
$ set PATH=%PATH;C:\Cygwin64\bin
$ setx PATH %PATH;C:\Cygwin64\bin
```
>Nota: si es una máquina de 32bit, sólo Cygwin en lugar 

#### Ejecuta bash
```bash
$ bash
```

#### Cambia al directorio home
```bash
$ cd /home
```

#### Descarga e instalación de `hsd`
```
$ git clone https://github.com/handshake-org/hsd
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
- Vaya y edite el package.json en la carpeta raíz `hsd/` para usar el archivo anterior

- Edita binding.gyp: `"<!(bash -c \"python -c 'from __future__ import print_function; import sys; print(sys.byteorder)'\")",`
- Continúa
```
$ cd ..
$ cd bsip
```
- Haz lo mismo con binding.gyp
- Continúa
```
$ cd ..
$ cd bstring
```
- Haz lo mismo con binding.gyp
- Continúa
```
$ cd ..
$ cd bcrypto
$ cd src
$ cd chacha20
$ mv chacha20.c chacha20_2.c
$ mv chacha20.h chacha20_2.h
```
- Reemplaza la referencia chacha20.h en chacha20_2.c a chacha20_2.h
- Continúa
```
$ cd ..
```
- Reemplaza la referencia chacha20.h en chacha20.h a chacha20_2.h y crypt_scrypt.c también necesita cambiar sha256_2.h
- Continúa
```
$ cd ..
```
- Reemplaza la referencia de chacha20/chacha20.c a chacha20/chacha20_2.c en binding.gyp
- Haz lo mismo para blake2b
- Haz lo mismo para sha256 (nota: Es solo en binding.gyp y no en src/sha256.h)
- Continue by going to root /hsd/ folder but make sure you edit package.json to do file: for the above modules.
- Continúa en la carpeta de root /hsd/ pero asegúrate que editas el package.json para hacer el archivo: para los módulos anteriores
```
$ npm install --production
$ cd ..
```

#### Sal de la terminal y establece mklink
```
$ mklink /D C:\home C:\Cygwin64\home
```

#### Abre la terminal de nuevo y inicia (en la testnet)
```bash
$ ./hsd/bin/hsd --daemon --no-auth
```

<br/>

## Instrucciones de instalación para `hnsd`
#### Descarga y compila `hnsd`
```bash
$ git clone https://github.com/handshake-org/hnsd
$ cd hnsd
$ ./autogen.sh && ./configure --with-network testnet && make
```

#### Inicia `hnsd`
```
$ ./hnsd.exe --pool-size=1 --rs-host=127.0.0.1:53
```

#### Cambia las DNS de windows establécelo en 127.0.0.1
