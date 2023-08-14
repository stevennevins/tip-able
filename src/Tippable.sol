// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Tippable {
    uint256 public totalLoot;
    uint256 public currentTip;
    uint256 internal subsidy;
    uint256 internal totalGasPrice;
    uint256 internal numTips;

    event Tip(address indexed origin, uint256 tip, uint256 totalLoot);

    modifier tip() {
        uint256 tip = tx.gasprice * subsidy * 120 / 100;
        totalGasPrice += tx.gasprice;
        numTips++;
        require(address(this).balance >= tip + totalLoot, "Insufficient tip");
        totalLoot += tip;
        emit Tip(tx.origin, tip, totalLoot);
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

    modifier payOutTip(uint256 _actions) {
        uint256 tips = subsidy * _actions * min(tx.gasprice, calculateAverageGasPrice());
        require(address(this).balance >= tips + totalLoot, "Insufficient tip");
        totalLoot += tips;
        emit Tip(tx.origin, tips, totalLoot);
        _;
    }
}
