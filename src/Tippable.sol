// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

    uint256 public currentTip;
    uint256 internal subsidy;

    event Tip(address indexed origin, uint256 tip);

    modifier tip() {
        uint256 tip = tx.gasprice * subsidy;
        require(address(this).balance >= tip, "Insufficient tip");
        emit Tip(tx.origin, tip);
        _;
    }

    function setCurrentTip(uint256 _currentTip) public {
        currentTip = _currentTip;
    }
    
    function _updateSubsidy(uint256 _subsidy) internal {
        subsidy = _subsidy;
    }
    
    // function removed
    
    function min(uint256 a, uint256 b) private pure returns (uint256) {
        return a < b ? a : b;
    }

    modifier payOutTip(uint256 _actions) {
        uint256 tips = subsidy * _actions * tx.gasprice;
        require(address(this).balance >= tips, "Insufficient tip");
        emit Tip(tx.origin, tips);
        _;
    }
}
