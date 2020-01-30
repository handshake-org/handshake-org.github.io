# Guía de instalación para macOS

El conjunto de software Handshake consta de un nodo completo (`hsd`) y un cliente ligero (`hnsd`). El nodo completo permite a los usuarios registrar, actualizar y transferir nombres, resolver nombres y realizar pagos en la cadena de bloques. El cliente ligero (nodo SPV) permite a los usuarios resolver nombres sin los requisitos de recursos informáticos de ejecutar un nodo completo.

Esta guía incluye instrucciones para instalar
[`hsd`](#hsd-installation-instructions) y
[`hnsd`](#hnsd-installation-instructions).

Consulte [el repositorio](https://github.com/handshake-org/hsd#install) para obtener actualizaciones.

<br/>

## Instrucciones para la instalación de `hsd`
#### Instalamos dependencias
Herramientas de línea de comandos de Xcode, Homebrew, node.js (>= v10) y git
```bash
$ xcode-select --install
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install node git
```

#### Descarga e instalación de `hsd`
```bash
$ git clone git@github.com:handshake-org/hsd.git
$ cd hsd
$ npm install --production
```

#### Inicio (en la testnet)
```bash
$ ./hsd/bin/hsd --daemon --no-auth
```

<br/>

## Instrucciones de instalación para `hnsd`
#### Instalamos dependencias
```bash
$ brew install git automake autoconf libtool unbound
```

#### Descarga y compilación de `hnsd`
```bash
$ git clone git@github.com:handshake-org/hnsd.git
$ cd hnsd
$ ./autogen.sh && ./configure --with-network=testnet && make
```

#### Inicio de `hnsd`
```bash
$ sudo ./hnsd --pool-size=1 --rs-host=127.0.0.1:53
```

#### Configurar las opciones del nombre del servidores
- Abrimos “System Preferences” en el panel/dock.
- Seleccionamos “Network”.
- Seleccionamos “Advanced”.
- Seleccionamos “DNS”
- Eliminamos todos los nombres de servidores y añadimos un único servidor: “127.0.0.1”
