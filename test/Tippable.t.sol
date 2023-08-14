// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Tippable} from "src/Tippable.sol";

contract TippableTest is Test {
    Tippable public tippable;

    function setUp() public {
        tippable = new Tippable();
    }

    function testTrue() public {
        assertTrue(true);
    }
}
