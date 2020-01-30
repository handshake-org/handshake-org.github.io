# Linux Install Guide

El conjunto de software Handshake consta de un nodo completo (`hsd`) y un cliente ligero (`hnsd`). El nodo completo permite a los usuarios registrar, actualizar y transferir nombres, resolver nombres y realizar pagos en la cadena de bloques. El cliente ligero (nodo SPV) permite a los usuarios resolver nombres sin los requisitos de recursos informáticos de ejecutar un nodo completo.

Esta guía incluye instrucciones para la instalación de 
[`hsd`](#hsd-installation-instructions) y
[`hnsd`](#hnsd-installation-instructions).

> Nota: Las instrucciones son específicas para Debian/Ubuntu. Asegúrese de usar el gestor de paquetes adecuado para su sistema operativo. BSDs y Solaris aún no han sido probados, pero en teoría, debería funcionar.

Consulte [el repositorio](https://github.com/handshake-org/hsd#install) para obtener actualizaciones.

<br/>

## Instrucciones de instalación de `hsd`
#### Instalamos dependencias
- node.js (>= v10)
- git
```
$ sudo apt install nodejs git
```

#### Descargamos e instalamos `hsd`
```
$ git clone git@github.com:handshake-org/hsd.git
$ cd hsd
$ npm install --production
```

#### Inicio (en la testnet)
```
$ ./hsd/bin/hsd --daemon --no-auth
```

<br/>

## Instrucciones de instalación para `hnsd`
#### Instalamos dependencias
```
$ sudo apt install automake autoconf libtool unbound libunbound-dev
```
>Nota: unbound-devel en yum

#### Descargamos y compilamos `hnsd`
```
git clone git@github.com:handshake-org/hnsd.git
cd hnsd
./autogen.sh && ./configure --with-network && make
```

#### iniciamos `hnsd`
```
sudo setcap 'cap_net_bind_service=+ep' /path/to/hnsd
./hnsd --pool-size=1 --rs-host=127.0.0.1:53
```

#### Configuramos las opciones del nombre del servidor
1. resolv.conf
```
$ echo 'nameserver 127.0.0.1' | sudo tee /etc/resolv.conf > /dev/null
```

2. Editamos resolvconf.conf para coincidir:
```
name_servers="127.0.0.1"
```
