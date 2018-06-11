# Handshake Developer Resources

## Prerequisites
You're going to need:
- Linux or OS X — Windows may work, but is unsupported.
- Ruby, version 2.3.1 or newer
- Bundler — If Ruby is already installed, but the bundle command doesn't work,
just run gem install bundler in a terminal.
- [Pandoc](https://pandoc.org/installing.html)

## Build
>NOTE: be sure to build site before submitting a pull request.
```
./build.sh
```

## Run
To view the site locally, run a simple http server from the project's root
directory.

Python:

```bash
$ python -m SimpleHTTPServer 8000
```

Ruby:
```bash
$ ruby -run -e httpd . -p 8000
```

Node.js:
```
$ npm install -g http-server
$ http-server -p 8000
