// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Tippable {
    uint256 public totalLoot;
    uint256 internal subsidy;

    event Tip(address indexed origin, uint256 tip, uint256 totalLoot);

    modifier tip() {
        uint256 tip = tx.gasprice * subsidy;
        require(address(this).balance >= tip + totalLoot, "Insufficient tip");
        totalLoot += tip;
        emit Tip(tx.origin, tip, totalLoot);
        _;
    }

    function _updateSubsidy(uint256 _subsidy) internal {
        subsidy = _subsidy;
    }

    function _payOutTips(uint256 _actions) internal {
        uint256 tips = subsidy * _actions * tx.gasprice;
    }
}
