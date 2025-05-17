// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract CryptoNoteToken is ERC721URIStorage {
    uint256 private _tokenIdCounter;

    // Mapping from owner address to list of owned token IDs
    mapping(address => uint256[]) private _ownedTokens;

    constructor() ERC721("CryptoNoteToken", "CNT") { }

    function mintNote(string memory tokenURI) public returns (uint256) {
        uint256 tokenId = _tokenIdCounter;

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _ownedTokens[msg.sender].push(tokenId);

        _tokenIdCounter += 1;

        return _tokenIdCounter;
    }
}
