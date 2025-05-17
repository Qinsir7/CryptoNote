// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {CryptoNoteToken} from "../src/CryptoNoteToken.sol";

contract CryptoNoteTokenScript is Script {
    CryptoNoteToken public cryptoNoteToken;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        cryptoNoteToken = new CryptoNoteToken();

        vm.stopBroadcast();
    }
}
