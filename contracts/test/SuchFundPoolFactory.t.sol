// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import "../src/SuchFundPoolFactory.sol";

/**
 * @title SuchFundPoolFactoryTest
 * @notice Test suite for SuchFundPoolFactory contract
 */
contract SuchFundPoolFactoryTest is Test {
    SuchFundPoolFactory public factory;

    address public owner = address(0x1);
    address public treasury = address(0x2);
    address public user = address(0x3);

    uint256 public constant INITIAL_FEE = 150; // 1.5%

    // Events to test
    event TreasuryUpdated(address indexed oldTreasury, address indexed newTreasury);
    event FeePercentageUpdated(uint256 oldPercentage, uint256 newPercentage);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function setUp() public {
        // Deploy factory as owner
        vm.prank(owner);
        factory = new SuchFundPoolFactory(treasury, INITIAL_FEE);
    }

    // ====================================
    // ====== CONSTRUCTOR TESTS ===========
    // ====================================

    function test_Constructor() public {
        assertEq(factory.owner(), owner);
        assertEq(factory.treasury(), treasury);
        assertEq(factory.platformFeePercentage(), INITIAL_FEE);
    }

    function test_Constructor_RevertIf_InvalidTreasury() public {
        vm.expectRevert(SuchFundPoolFactory.InvalidAddress.selector);
        new SuchFundPoolFactory(address(0), INITIAL_FEE);
    }

    function test_Constructor_RevertIf_InvalidFeePercentage() public {
        vm.expectRevert(SuchFundPoolFactory.InvalidFeePercentage.selector);
        new SuchFundPoolFactory(treasury, 10001); // Over 100%
    }

    // ====================================
    // ===== TREASURY UPDATE TESTS ========
    // ====================================

    function test_SetTreasury() public {
        address newTreasury = address(0x4);

        vm.expectEmit(true, true, false, false);
        emit TreasuryUpdated(treasury, newTreasury);

        vm.prank(owner);
        factory.setTreasury(newTreasury);

        assertEq(factory.treasury(), newTreasury);
    }

    function test_SetTreasury_RevertIf_NotOwner() public {
        address newTreasury = address(0x4);

        vm.expectRevert(SuchFundPoolFactory.Unauthorized.selector);
        vm.prank(user);
        factory.setTreasury(newTreasury);
    }

    function test_SetTreasury_RevertIf_InvalidAddress() public {
        vm.expectRevert(SuchFundPoolFactory.InvalidAddress.selector);
        vm.prank(owner);
        factory.setTreasury(address(0));
    }

    // ====================================
    // ==== FEE PERCENTAGE TESTS ==========
    // ====================================

    function test_SetFeePercentage() public {
        uint256 newFee = 200; // 2%

        vm.expectEmit(false, false, false, true);
        emit FeePercentageUpdated(INITIAL_FEE, newFee);

        vm.prank(owner);
        factory.setFeePercentage(newFee);

        assertEq(factory.platformFeePercentage(), newFee);
    }

    function test_SetFeePercentage_RevertIf_NotOwner() public {
        vm.expectRevert(SuchFundPoolFactory.Unauthorized.selector);
        vm.prank(user);
        factory.setFeePercentage(200);
    }

    function test_SetFeePercentage_RevertIf_TooHigh() public {
        vm.expectRevert(SuchFundPoolFactory.InvalidFeePercentage.selector);
        vm.prank(owner);
        factory.setFeePercentage(10001); // Over 100%
    }

    function testFuzz_SetFeePercentage(uint256 percentage) public {
        vm.assume(percentage <= 10000); // Valid range

        vm.prank(owner);
        factory.setFeePercentage(percentage);

        assertEq(factory.platformFeePercentage(), percentage);
    }

    // ====================================
    // ===== OWNERSHIP TESTS ==============
    // ====================================

    function test_TransferOwnership() public {
        address newOwner = address(0x5);

        vm.expectEmit(true, true, false, false);
        emit OwnershipTransferred(owner, newOwner);

        vm.prank(owner);
        factory.transferOwnership(newOwner);

        assertEq(factory.owner(), newOwner);
    }

    function test_TransferOwnership_RevertIf_NotOwner() public {
        address newOwner = address(0x5);

        vm.expectRevert(SuchFundPoolFactory.Unauthorized.selector);
        vm.prank(user);
        factory.transferOwnership(newOwner);
    }

    function test_TransferOwnership_RevertIf_InvalidAddress() public {
        vm.expectRevert(SuchFundPoolFactory.InvalidAddress.selector);
        vm.prank(owner);
        factory.transferOwnership(address(0));
    }

    // ====================================
    // ===== VIEW FUNCTION TESTS ==========
    // ====================================

    function test_Version() public {
        string memory ver = factory.version();
        assertEq(ver, "1.0.0");
    }

    function test_Constants() public {
        assertEq(factory.ALLO(), 0x1133eA7Af70876e64665ecD07C0A0476d09465a1);
        assertEq(factory.REGISTRY(), 0x4AAcca72145e1dF2aeC137E1f3C5E3D75DB8b5f3);
        assertEq(factory.DEFAULT_STRATEGY(), 0x787eC93Dd71a90563979417879F5a3298389227f);
    }

    // ====================================
    // ===== CREATE POOL TESTS ============
    // ====================================
    // Note: Full implementation will be added in Phase 1

    function test_CreatePool_Placeholder() public {
        // This test will be expanded once createPool is fully implemented
        address profileId = address(0x10);
        address strategy = address(0);
        address token = address(0x11);
        uint256 matchingFunds = 100 ether;
        string memory metadata = "ipfs://QmTest";

        // Currently returns 0 (placeholder)
        uint256 poolId = factory.createPool(profileId, strategy, token, matchingFunds, metadata);

        // Once implemented, this would return a real pool ID
        assertEq(poolId, 0);
    }
}
