// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "../src/SuchFundPoolFactory.sol";

/**
 * @title DeployScript
 * @notice Deployment script for Such.Fund contracts
 * @dev Run with: forge script script/Deploy.s.sol:DeployScript --rpc-url <network> --broadcast --verify
 */
contract DeployScript is Script {
    // Load from environment variables
    address public treasury = vm.envAddress("TREASURY_ADDRESS");
    uint256 public platformFeePercentage = vm.envUint("PLATFORM_FEE_PERCENTAGE");

    function run() external {
        // Get deployer private key from environment
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        // Start broadcasting transactions
        vm.startBroadcast(deployerPrivateKey);

        // Deploy SuchFundPoolFactory
        SuchFundPoolFactory factory = new SuchFundPoolFactory(treasury, platformFeePercentage);

        console.log("======================================");
        console.log("Such.Fund Contracts Deployed");
        console.log("======================================");
        console.log("Network:", block.chainid);
        console.log("Deployer:", vm.addr(deployerPrivateKey));
        console.log("SuchFundPoolFactory:", address(factory));
        console.log("Treasury:", treasury);
        console.log("Platform Fee:", platformFeePercentage, "bps");
        console.log("======================================");

        // Stop broadcasting
        vm.stopBroadcast();

        // Verify deployment
        require(factory.owner() == vm.addr(deployerPrivateKey), "Owner mismatch");
        require(factory.treasury() == treasury, "Treasury mismatch");
        require(factory.platformFeePercentage() == platformFeePercentage, "Fee mismatch");

        console.log("Deployment verified successfully!");
    }
}
