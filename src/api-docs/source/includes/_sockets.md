# Sockets

Socket events use the socket.io protocol.

Socket IO implementations:

- JS: [https://github.com/socketio/socket.io-client](https://github.com/socketio/socket.io-client)
- Python: [https://github.com/miguelgrinberg/python-socketio](https://github.com/miguelgrinberg/python-socketio)
- Go: [https://github.com/googollee/go-socket.io](https://github.com/googollee/go-socket.io)
- C++: [https://github.com/socketio/socket.io-client-cpp](https://github.com/socketio/socket.io-client-cpp)
- bsock: [https://github.com/bcoin-org/bsock](https://github.com/bcoin-org/bsock) (recommended!)

`bsock` is a minimal websocket-only implementation of the socket.io protocol,
complete with ES6/ES7 features, developed by the bcoin team. `bsock` is used
throughout the bcoin and hsd ecosystem including
[`hs-client`](https://github.com/handshake-org/hs-client).
Examples below describe usage with `bsock` specifically.

For a deeper dive into events and sockets in hsd, including a tutorial
on using `bsock` and `hs-client`, see the
[handshake.org Events and Sockets Guide.](https://handshake-org.github.io/guides/events.html)
