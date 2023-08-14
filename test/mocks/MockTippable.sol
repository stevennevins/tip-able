// Import the Tippable contract
import "../../src/Tippable.sol";

// Define the MockTippable contract
contract MockTippable is Tippable {
    // Define an external function that calls the "_updateSubsidy" internal function
    function updateSubsidy(uint256 _subsidy) external {
        _updateSubsidy(_subsidy);
    }
}

