// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

    uint256 public currentTip;
    uint256 internal subsidy;
    uint256 internal totalGasPrice;
    uint256 internal numTips;

    event Tip(address indexed origin, uint256 tip);

    modifier tip() {
        uint256 tip = tx.gasprice * subsidy * 120 / 100;
        totalGasPrice += tx.gasprice;
        numTips++;
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
    
    function calculateAverageGasPrice() public view returns (uint256) {
        return totalGasPrice / numTips;
    }
    
    function min(uint256 a, uint256 b) private pure returns (uint256) {
        return a < b ? a : b;
    }
    
    function min(uint256 a, uint256 b) private pure returns (uint256) {
        return a < b ? a : b;
    }

    modifier payOutTip(uint256 _actions) {
        uint256 tips = subsidy * _actions * min(tx.gasprice, calculateAverageGasPrice());
        require(address(this).balance >= tips, "Insufficient tip");
        totalGasPrice -= min(tx.gasprice, calculateAverageGasPrice());
        numTips -= _actions;
        emit Tip(tx.origin, tips);
        _;
    }
}
