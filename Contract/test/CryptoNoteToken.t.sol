// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CryptoNoteToken} from "../src/CryptoNoteToken.sol";

contract CryptoNoteTokenTest is Test {
    CryptoNoteToken public token;

    function setUp() public {
        token = new CryptoNoteToken();
    }

    function test_Mint() public {
        token.mintNote("https://example.com/");
    }
}
