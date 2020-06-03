## Handshake Resource Record Guide

Handshake has resource records that represent DNS resource records.
Some of them map one-to-one with DNS resource record types,
while others do not. These resource records are included in
`REGISTER` or `UPDATE` outputs and written to the Urkel tree
so that proofs can be served to light clients.

Each Handshake name stores a single `Resource` with the maximum size of
512 bytes.

### Updating Resource Records

To update the resource records associated with a name, the wallet RPC
command `sendupdate` is used. If the name is in a different wallet
than the primary wallet, use the RPC command `selectwallet` before
sending the update. The Node RPC method `verifyresource` can be used
to check if the resource is valid before attempting to `sendupdate`.

```bash
$ hsw-cli rpc sendupdate easyhandshake '{"records": []}'
```

Note that there are no `records` being included in this example.
When calling `sendupdate` for the first time after winning an
auction, a `REGISTER` output is created along with a change output
that includes the difference between the user's bid and the
second highest bid. Use the Node RPC `getnameresource` to view
the resources for a name. Newly updated names will not reflect their
records via DNS until a tree inverval is passed, which happens
every 36 blocks.

### Resource Record Types

- `DS`
- `NS`
- `GLUE4`
- `GLUE6`
- `SYNTH4`
- `SYNTH6`
- `TXT`

#### `DS`

The `DS` Handshake resource record is the same as the DNS
`DS` resource record. It it used for DNSSEC and is specified
in [RFC 4033](http://tools.ietf.org/html/rfc4033),
[RFC 4034](http://tools.ietf.org/html/rfc4034) and
[RFC 4035](http://tools.ietf.org/html/rfc4035).
Its purpose it to enable secure delegation of zones by creating
a chain of authentication between a parent and child zone.
The `DS` record contains the hash of a `DNSKEY` resource record.
It is inserted into the parent zone and the `DNSKEY` record
is inserted into the child zone.
The Handshake `DS` record must contain the fields `type`,
`keyTag`, `algorithm`, `digestType` and `digest`.
See [RFC 4034](https://tools.ietf.org/html/rfc4034) for the
definitions of these fields.

Example:

```json
{
  "records": [{
    "type": "DS",
    "keyTag": 24620, 
    "algorithm": 8,
    "digestType": 2, 
    "digest": "297595dc199b947aa8650923619436fbdfd99fd625195111ab4efe950900cade"
  }]
}
```

#### `NS`

The `NS` Handshake resource record is the same as the DNS
`NS` resource record. It is used to delegate authority of a name
to an authoritative nameserver. It is specified in
[RFC 1035](https://tools.ietf.org/html/rfc1035).
The Handshake `NS` record must contain the fields `type` and `ns`.
The `ns` field must be a fully qualified domain name, including
a trailing dot. It is useful when the `ns` name is resolvable
via ICANN, but can also delegate authority to a name rooted in
Handshake.

Example:

```json
{
  "records": [{
    "type": "NS",
    "ns": "ns1.easyhandshake.org."
  }]
}
```

#### `GLUE4`

The `GLUE4` Handshake resource record corresponds to two DNS 
resource records, a `NS` record and an `A` record. The `A`
record is used as the glue. `A` records are defined in
[RFC 1035](https://tools.ietf.org/html/rfc1035) and must contain
an IPv4 address. The Handshake `GLUE4` record must contain the
fields `type`, `ns` and `address`. It is useful for setting
up an authoritative nameserver to manage subdomains for
a Handshake name. The `address` field will be included in the
additional section of the DNS response as an `A` record.

Example:

```json
{
  "records": [{
    "type": "GLUE4",
    "ns": "ns1.bitcoin.hat.",
    "address": "172.21.0.08"
  }]
}
```

The name `easyhandshake` is set up here with a `GLUE4` record.

```bash
$ hsd-cli rpc getnameresource easyhandshake
{
  "records": [
    {
      "type": "GLUE4",
      "ns": "ns1.coop.easyhandshake.",
      "address": "127.0.1.1"
    }
  ]
}
```

This says that there is an authoritative name server `ns` with
the name `ns1.coop.easyhandshake.` This name alone isn't useful
to the client, it also needs an IP address for that name. The
IP address is in what is referred to as a glue record. For the
Handshake `GLUE4` record, an `A` record used as glue. The glue
record has the name at `ns` and the IPv4 address at `address`.

It will resolve via the authoritative name server like this:

```bash
$ dig @127.0.0.1 -p 25349 easyhandshake

; <<>> DiG 9.16.2 <<>> @127.0.0.1 -p 25349 easyhandshake
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 31231
;; flags: qr rd; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 2
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;easyhandshake.         IN  A

;; AUTHORITY SECTION:
easyhandshake.      21600   IN  NS  ns1.coop.easyhandshake.

;; ADDITIONAL SECTION:
ns1.coop.easyhandshake. 21600   IN  A   127.0.1.1

;; Query time: 0 msec
;; SERVER: 127.0.0.1#25349(127.0.0.1)
;; WHEN: Wed May 13 22:23:11 PDT 2020
;; MSG SIZE  rcvd: 81
```

Set up an authoritative name server at `127.0.1.1` and resource
records served by that zone will now be available via the
Handshake recursive resolver.

#### `GLUE6`

The `GLUE6` Handshake resource record corresponds to two DNS 
resource records, a `NS` record and an `AAAA` record. The `AAAA`
record is used as the glue. `AAAA` records are defined in
[RFC 1035](https://tools.ietf.org/html/rfc1035) and must contain
an IPv6 address. The Handshake `GLUE6` record must contain the
fields `type`, `ns` and `address`. It is useful for setting
up an authoritative nameserver to manage subdomains for
a Handshake name. The `address` field will be included in the
additional section of the DNS response as an `AAAA` record.

Example:

```json
{
  "records": [{
    "type": "GLUE6",
    "ns": "ns1.bitcoin.lawl.",
    "address": "9530:f7fb:dc28:c1a3:d17f:d3f0:b875:aba8"
  }]
}
```

This is the same as `GLUE4` but with IPv6.

#### `TXT`

The `TXT` Handshake resource record corresponds to the DNS
`TXT` record. It is used to store arbitrary data and many
protocols are built on top of it. `TXT` records are defined
in [RFC 1035](https://tools.ietf.org/html/rfc1035). It is useful
for placing arbitrary data on chain. The Handshake `TXT` record
must contain the fields `type` and `text`. The `text` field
must be an array of strings.

Example:

```json
{
  "records": [{
    "type": "TXT",
    "text": ["my text record"]
  }]
}
```

The name `easyhandshake` is set up here with two `TXT` records.

```bash
{
  "records": [
    {
      "type": "TXT",
      "txt": [
        "imagine if gold turned to lead when stolen, if thief gives back, it turns to gold again"
      ]
    },
    {
      "type": "TXT",
      "txt": [
        "proof of",
        "work speaks",
        "for itself"
      ]
    }
  ]
}
```

It will resolve via both the authoritative name server and recursive
name server like this:

```bash
$ dig @127.0.0.1 -p 25349 easyhandshake TXT

; <<>> DiG 9.16.2 <<>> @127.0.0.1 -p 25349 easyhandshake TXT
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 8003
;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;easyhandshake.         IN  TXT

;; ANSWER SECTION:
easyhandshake.      21600   IN  TXT "imagine if gold turned to lead when stolen, if thief gives back, it turns to gold again"
easyhandshake.      21600   IN  TXT "proof of" "work speaks" "for itself"

;; Query time: 3 msec
;; SERVER: 127.0.0.1#25349(127.0.0.1)
;; WHEN: Wed May 13 22:59:28 PDT 2020
;; MSG SIZE  rcvd: 186
```
