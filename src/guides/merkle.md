# HSD - Merkle Tree

Merkle hash trees are used to audit/verify large data structures. Handshake,
Bitcoin and many other protocols use it for transaction hashes to provide
efficient proofs of inclusion.

Handshake uses different merkle hash tree for transactions from bitcoin.
Hash tree is based on [RFC 6962][rfc6962] and integrates padding idea from
[RFC 7574][rfc7574]. Motivation to change to different merkle tree
is to fix problems of the bitcoin merkle tree.

## How it works

Handshake merkle tree uses `blake2b` as the hash function for the tree.
In general it follows flow described in [RFC 6962][rfc6962].

Given `n` inputs `d[0...n]`, first each of them is hashed as
`blake2b(0x00 || d[i])`.   
All internal nodes are hashed using
`blake2b(0x01 || leftHash || rightHash)`, but if `rightHash` is
missing then `EMPTY_HASH` is used instead. This is similar to
[RFC 7574][rfc7574].

  - `EMPTY_HASH = blake2b(EMPTY_BUFFER)`


### Example 1

Block with 4 transactions

```text
      merkle root     
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
 - `merkle root` = `blake2b(0x01 || e || f)`

### Example 2

Block with 6 transactions

```text
                merkle root                        
               /           \                       
              /             \                      
             /               \                     
            /                 \                    
           j                   k                   
          / \                 / \                  
         /   \               /   \                 
        /     \             /     \                
       /       \           /       \               
      g         h         i         blake2b(empty) 
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
  - `merkle root` = `blake2b(0x01 || j || k)`

### Example 3
Block with 5 transactions

```text
                merkle root                        
               /           \                       
              /             \                      
             /               \                     
            /                 \                    
           i                   j                   
          / \                 / \                  
         /   \               /   \                 
        /     \             /     \                
       /       \           /       \               
      f         g         h         blake2b(empty) 
     / \       / \       / \                       
    /   \     /   \     /   \                      
   a     b   c     d   e     blake2b(empty)        
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
  - `merkle root` = `blake2b(0x01 || i || j)`
      
### Example 5
Block with 1 transaction.
```text
  merkle root
      |
      d0
```
  - `merkle root` = `blake2b(0x00 || d0)`

[gh-issue]: https://github.com/handshake-org/hsd/issues/5
[rfc6962]: https://tools.ietf.org/html/rfc6962#section-2.1
[rfc7574]: https://tools.ietf.org/html/rfc7574#section-5.1
