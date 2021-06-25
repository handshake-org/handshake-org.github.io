# HSD - Merkle Tree

Merkle hash trees are used to audit/verify large data structures. Handshake,
Bitcoin and many other protocols use it with transaction hashes to provide
efficient proofs of inclusion in blocks.

Handshake uses a different Merkle hash tree than Bitcoin for transactions.
The Handshake hash tree is based on [RFC 6962][rfc6962] and integrates a padding
idea from [RFC 7574][rfc7574]. The motivation to switch Merkle tree algorithms
was to fix known issues with the Bitcoin Merkle tree: [hsd discussion][issue5],
[attack description][merkleattack].

## How it works

The Handshake Merkle tree uses `blake2b` as the hash function.
In general it follows the flow described in [RFC 6962][rfc6962]:

1. Define `EMPTY_HASH = blake2b(EMPTY_BUFFER)`

2. Given `n` inputs `d[0...n]`, each input is hashed as `blake2b(0x00 || d[i])`.
These inputs are transaction hashes (txid).

3. All internal nodes are hashed using
`blake2b(0x01 || leftHash || rightHash)`, but if `rightHash` is
missing then `EMPTY_HASH` is used instead. This is similar to
[RFC 7574][rfc7574].

### Example 1

Block with 4 transactions:

```text
      Merkle root     
          / \         
         /   \        
        /     \       
       /       \      
      e         f     
     / \       / \    
    /   \     /   \   
   a     b   c     d  
   |     |   |     |  
   d0    d1  d2    d3 
```
 - `a` = `blake2b(0x00 || d0)`
 - `b` = `blake2b(0x00 || d1)`
 - `c` = `blake2b(0x00 || d2)`
 - `d` = `blake2b(0x00 || d3)`
 - `e` = `blake2b(0x01 || a || b)`
 - `f` = `blake2b(0x01 || c || d)`
 - `Merkle root` = `blake2b(0x01 || e || f)`

### Example 2

Block with 6 transactions:

```text
                Merkle root                        
               /           \                       
              /             \                      
             /               \                     
            /                 \                    
           j                   k                   
          / \                 / \                  
         /   \               /   \                 
        /     \             /     \                
       /       \           /       \               
      g         h         i         EMPTY_HASH
     / \       / \       / \                       
    /   \     /   \     /   \                      
   a     b   c     d   e     f                     
   |     |   |     |   |     |                     
   d0    d1  d2    d3  d4    d5                    
```

  - `a` = `blake2b(0x00 || d0)`
  - `b` = `blake2b(0x00 || d1)`
  - `c` = `blake2b(0x00 || d2)`
  - `d` = `blake2b(0x00 || d3)`
  - `e` = `blake2b(0x00 || d4)`
  - `f` = `blake2b(0x00 || d5)`
  - `g` = `blake2b(0x01 || a || b)`
  - `h` = `blake2b(0x01 || c || d)`
  - `i` = `blake2b(0x01 || e || f)`
  - `j` = `blake2b(0x01 || g || h)`
  - `k` = `blake2b(0x01 || i || EMPTY_HASH)`
  - `Merkle root` = `blake2b(0x01 || j || k)`

### Example 3

Block with 5 transactions:

```text
                Merkle root                        
               /           \                       
              /             \                      
             /               \                     
            /                 \                    
           i                   j                   
          / \                 / \                  
         /   \               /   \                 
        /     \             /     \                
       /       \           /       \               
      f         g         h         EMPTY_HASH 
     / \       / \       / \                       
    /   \     /   \     /   \                      
   a     b   c     d   e     EMPTY_HASH        
   |     |   |     |   |                           
   d0    d1  d2    d3  d4                          
```
  - `a` = `blake2b(0x00 || d0)`
  - `b` = `blake2b(0x00 || d1)`
  - `c` = `blake2b(0x00 || d2)`
  - `d` = `blake2b(0x00 || d3)`
  - `e` = `blake2b(0x00 || d4)`
  - `f` = `blake2b(0x01 || a || b)`
  - `g` = `blake2b(0x01 || c || d)`
  - `h` = `blake2b(0x01 || e || EMPTY_HASH)`
  - `i` = `blake2b(0x01 || f || g)`
  - `j` = `blake2b(0x01 || h || EMPTY_HASH)`
  - `Merkle root` = `blake2b(0x01 || i || j)`
      
### Example 5

Block with 1 transaction:

```text
  Merkle root
      |
      d0
```
  - `Merkle root` = `blake2b(0x00 || d0)`

## Implementations

[Bitcoin Merkle Tree](https://github.com/bcoin-org/bcrypto/blob/master/lib/merkle.js)

[Handshake Merkle Tree](https://github.com/bcoin-org/bcrypto/blob/master/lib/mrkl.js)

[gh-issue]: https://github.com/handshake-org/hsd/issues/5
[rfc6962]: https://tools.ietf.org/html/rfc6962#section-2.1
[rfc7574]: https://tools.ietf.org/html/rfc7574#section-5.1
[issue5]: https://github.com/handshake-org/hsd/issues/5
[merkleattack]: https://bitslog.com/2018/06/09/leaf-node-weakness-in-bitcoin-merkle-tree-design/