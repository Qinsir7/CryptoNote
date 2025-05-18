## CryptoNoteToken Contract
Implements OpenZeppelin ERC721 token with URI storage.
User can interact with contract to issue new NFT tokens.

## Usage

### Build Contract

```shell
$ forge build
```

### Deploy to BNB Chain Testnet

```shell
$ forge script script/CryptoNoteToken.s.sol --rpc-url bnb-testnet --broadcast --private-key <your_private_key>
```
