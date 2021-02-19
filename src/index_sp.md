## Introducción:

Handshake es un protocolo de cadena de bloques basado en UTXO que gestiona el registro, la renovación y la transferencia de dominios de primer nivel (TLD) de DNS. Nuestro protocolo de asignación de nombres difiere de sus predecesores en que no tiene concepto de espacio de nombres o subdominios en la capa de consenso. Su propósito no es reemplaar DNS, sino reemplazar el archivo de zona raíz y los servidores raíz.

El daemon de nodo completo, [hsd](https://github.com/handshake-org/hsd), está escrito en JavaScript y es una bifurcación de [bcoin](https://bcoin.io). Ejecutando un nodo completo puede participar en la seguridad de la red y servir el archivo de zona raíz incrustado en el bloque.

También tienen un cliente SPV, [hnsd](https://github.com/handshake-org/hnsd), que está escrito en C. Actúa como un cliente ligero para la cadena de bloques, así como un servidor de nombres recursivo. Puede servir registros de recursos comprobables y verificar pagos sin tener los requisitos de recursos de un nodo completo.

Al instalar y/o contribuir con Handshake, estamos participando en una plataforma abierta descentralizada propiedad de los usuarios.

### Código fuente

El último código fuente está disponible en [GitHub](https://github.com/handshake-org) bajo la [licencia MIT](https://opensource.org/licenses/mit-license.php).

### Monedas

Handshake utiliza un sistema de utilidad de monedas para el registro de nombres. Handshake depende de la comunidad libre y de código abierto para asumir la propiedad y descentralizar el sistema [https://handshake.org](https://handshake.org).

### Comunidades de Desarrolladores

-   IRC: irc.freenode.net: #handshake.
-   Telegram: [Handshake Dev Chat](https://t.me/hns_tech).

### ¿Ves un fallo? Abre un pull request.

https://github.com/handshake-org/handshake-org.github.io/blob/master/src/index.md
