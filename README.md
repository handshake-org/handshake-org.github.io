# Handshake Developer Documentation Site
Handshake is a UTXO-based blockchain protocol which manages the
registration, renewal and transfer of DNS top-level domains (TLDs).

This is the GitHub Pages hosted website for the
[Handshake protocol](https://handshake-org.github.io).
This site includes, API docs, JSdoc generated documentation,
instructional guides, and links to the white paper and
protocol spec.

## Dependencies
To work on this site you will need:
- Linux or macOS (Windows may work, but is unsupported).
- Ruby, version 2.3.1 or newer
- Bundler — If Ruby is already installed, but the bundle command doesn't work,
just run gem install bundler in a terminal.
- [Pandoc](https://pandoc.org/installing.html)

## Build

Build site and slate api docs:
```bash
./bin/build
```

Build jsdoc:
```bash
./bin/build-docs
```

## Run
To view the site locally, run a simple http server from the project's
root directory. 

Python:

```bash
$ python -m SimpleHTTPServer 8080
```

Ruby:
```bash
$ ruby -run -e httpd . -p 8080
```

Node.js:
```bash
$ npm install -g http-server
$ http-server -p 8080
```

The site will run at [http://locahost:8080](http://localhost:8080).

## Updating API Docs
The [API Documentation](https://handshake-org.github.io/api-docs/index.html)
runs on the Open Source [Slate Framework](https://github.com/lord/slate).
To make an update, fork the repo and make the changes to the appropriate
markdown in this [file directory](https://github.com/handshake-org/handshake-org.github.io/tree/master/src/api-docs/source/includes/).
To use livereload while working on the API docs, use middleman livereload like so:
``` bash
$ cd ./handshake-org.github.io/src/api-docs/
$ bundle install
$ bundle exec middleman server
```

When your PR is merged the new docs will be deployed to the live docs page.

## Guide Contribution Guidelines
### Submitting Ideas
Have an idea for a guide or tutorial? First head on over to the
[GitHub issues](https://github.com/handshake-org/handshake-org.github.io/issues)
and see if your idea is already posted. If not, create an issue.

### Adding a New Guide
To add a new guide, just a submit a pull request (PR) with a markdown
file added to the `src/guides` directory in this repo (take a look at
some of the other guides [here](https://github.com/handshake-org/handshake-org.github.io/tree/master/src/guides)).
If your PR is accepted, it will added to the website.

Be sure to build the site before submitting your PR.
