## How to run pseudo-airgapped hs-airdrop using Docker

First, create this `Dockerfile` in an empty directory:

```Dockerfile
FROM node

RUN git clone https://github.com/handshake-org/hs-airdrop.git /hs-airdrop
WORKDIR /hs-airdrop
RUN yarn
RUN mkdir -p /root/.hs-tree-data/nonces
RUN curl -Lo /root/.hs-tree-data/tree.bin https://github.com/handshake-org/hs-tree-data/raw/master/tree.bin
RUN curl -Lo /root/.hs-tree-data/faucet.bin https://github.com/handshake-org/hs-tree-data/raw/master/faucet.bin
RUN curl -Lo /root/.hs-tree-data/proof.json https://github.com/handshake-org/hs-tree-data/raw/master/proof.json
RUN curl -Lo /root/.hs-tree-data/nonces/172.bin https://github.com/handshake-org/hs-tree-data/raw/master/nonces/172.bin
```

Open a terminal, change to that directory, and run the following commands:

```bash
mkdir keys
cp ~/.ssh/id_rsa ~/.ssh/id_rsa.pub keys
# Change the password on your SSH key
ssh-keygen -p -f keys/id_rsa

docker build -t hs-airdrop .

docker run --rm -it --network none --name no-net --volume=$(pwd)/keys:/ssh hs-airdrop bash
```

You'll now be running a non-networked container. This is not as secure as it
could be if you properly air-gapped, but it's better than nothing. Inside the
container you can check there's no network connectivity:

```bash
ping 8.8.8.8
```

Should give an error - so you know there's no internet. Now run the hs-airdrop
command:

```bash
./bin/hs-airdrop /ssh/id_rsa <YOUR_WALLET_ADDRESS> 0.010
```

(0.010 is the mining fee recommended by namebase.io)

You'll probably get an error about not being able to fetch the nonce; this is
likely because bucket `172` above is incorrect for you - take a note of the
nonce number in the "Downloading..." URL. Exit the docker bash shell, edit the
Dockerfile above to contain the correct bucket number (in BOTH PLACES on that
final line), then run again:

```bash
docker build -t hs-airdrop .

docker run --rm -it --network none --name no-net --volume=$(pwd)/keys:/ssh hs-airdrop bash
```

Issue the `./bin/hs-airdrop` command again and hopefully this time it will work.
