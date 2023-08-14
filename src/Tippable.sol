// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

    uint256 public totalTips;
    uint256 internal subsidy;

    event Tip(address indexed origin, uint256 tip);

    modifier tip() {
    modifier tip() {
    modifier tip() {
        uint256 tip = tx.gasprice * subsidy;
        require(address(this).balance >= tip + totalTips, "Insufficient tip");
        emit Tip(tx.origin, tip);
    }
    function setTotalTips(uint256 _totalTips) public {
        totalTips = _totalTips;
    }
    
    function _updateSubsidy(uint256 _subsidy) internal {
        subsidy = _subsidy;
    }
    
    // function removed
    
    function averageGasPrice() private view returns (uint256) {
        return totalGasPrice / numberOfTips;
    }

    modifier payOutTip(uint256 _actions) {
    modifier payOutTip(uint256 _actions) {
        _;
        uint256 tips = subsidy * _actions * min(averageGasPrice(), tx.gasprice);
        tips = min(address(this).balance, tips);
        emit Tip(tx.origin, tips);
    }
