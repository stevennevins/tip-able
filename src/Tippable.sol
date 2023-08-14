// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Tippable {
    uint256 public totalTips;
    uint256 internal subsidy;
    uint256 internal totalGasPrice;
    uint256 internal numberOfTips;

    modifier tip() {
        uint256 tipAmount = tx.gasprice * subsidy;
        require(address(this).balance >= tipAmount + totalTips, "Insufficient tip");
        _;
    }

    function setTotalTips(uint256 _totalTips) public {
        totalTips = _totalTips;
    }

    function _updateSubsidy(uint256 _subsidy) internal {
        subsidy = _subsidy;
    }

    function min(uint256 a, uint256 b) internal returns (uint256) {
        return (a > b) ? b : a;
    }

    function averageGasPrice() private view returns (uint256) {
        return totalGasPrice / numberOfTips;
    }

    modifier payOutTip(uint256 _actions) {
        _;
        uint256 tips = subsidy * _actions * min(averageGasPrice(), tx.gasprice);
        tips = min(address(this).balance, tips);
    }
}
