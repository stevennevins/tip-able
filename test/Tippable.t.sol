// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Tippable} from "../src/Tippable.sol";

contract TippableTest is Test {
    Tippable public tippable;

    function setUp() public {
        tippable = new Tippable();
    }

    function testTip() public {
        uint256 initialBalance = tippable.balance;
        tippable.tip{value: 1 ether}();
        assertEq(tippable.balance, initialBalance + 1 ether);
    }

    function testPayoutTips() public {
        uint256 initialBalance = tippable.balance;
        tippable.payOutTip(1);
        assertEq(tippable.balance, initialBalance - 1 ether);
    }
}
