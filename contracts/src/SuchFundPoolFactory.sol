// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.19;

/**
 * @title SuchFundPoolFactory
 * @notice Helper contract for creating Allo pools with Such.Fund-specific configurations
 * @dev Wraps Allo.createPool() with sensible defaults for quadratic funding rounds
 * @author Such.Fund Team
 */
contract SuchFundPoolFactory {
    /// @notice Allo Protocol core contract address
    /// @dev Same address on all supported networks
    address public constant ALLO = 0x1133eA7Af70876e64665ecD07C0A0476d09465a1;

    /// @notice Registry contract address
    address public constant REGISTRY = 0x4AAcca72145e1dF2aeC137E1f3C5E3D75DB8b5f3;

    /// @notice Default QF strategy (DonationVotingMerkleDistributionVault)
    address public constant DEFAULT_STRATEGY = 0x787eC93Dd71a90563979417879F5a3298389227f;

    /// @notice Such.Fund treasury address for platform fees
    address public treasury;

    /// @notice Platform fee percentage in basis points (e.g., 150 = 1.5%)
    uint256 public platformFeePercentage;

    /// @notice Contract owner
    address public owner;

    // ====================================
    // ============= EVENTS ===============
    // ====================================

    event PoolCreated(
        uint256 indexed poolId,
        address indexed profileId,
        address strategy,
        address token,
        uint256 matchingFunds,
        string metadata
    );

    event TreasuryUpdated(address indexed oldTreasury, address indexed newTreasury);
    event FeePercentageUpdated(uint256 oldPercentage, uint256 newPercentage);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // ====================================
    // ============= ERRORS ===============
    // ====================================

    error Unauthorized();
    error InvalidAddress();
    error InvalidFeePercentage();

    // ====================================
    // =========== MODIFIERS ==============
    // ====================================

    modifier onlyOwner() {
        if (msg.sender != owner) revert Unauthorized();
        _;
    }

    // ====================================
    // =========== CONSTRUCTOR ============
    // ====================================

    /**
     * @notice Initialize the factory contract
     * @param _treasury Address to receive platform fees
     * @param _platformFeePercentage Fee percentage in basis points (max 10000 = 100%)
     */
    constructor(address _treasury, uint256 _platformFeePercentage) {
        if (_treasury == address(0)) revert InvalidAddress();
        if (_platformFeePercentage > 10000) revert InvalidFeePercentage();

        owner = msg.sender;
        treasury = _treasury;
        platformFeePercentage = _platformFeePercentage;

        emit TreasuryUpdated(address(0), _treasury);
        emit FeePercentageUpdated(0, _platformFeePercentage);
    }

    // ====================================
    // ======== EXTERNAL FUNCTIONS ========
    // ====================================

    /**
     * @notice Create a new quadratic funding pool
     * @dev This is a simplified wrapper - actual implementation would call Allo.createPool()
     * @param profileId The profile ID from the Registry
     * @param strategy The allocation strategy to use (or address(0) for default)
     * @param token The token to use for the pool
     * @param matchingFunds The amount of matching funds
     * @param metadata IPFS hash or JSON string with pool metadata
     * @return poolId The ID of the created pool
     */
    function createPool(
        address profileId,
        address strategy,
        address token,
        uint256 matchingFunds,
        string calldata metadata
    ) external returns (uint256 poolId) {
        if (profileId == address(0)) revert InvalidAddress();
        if (token == address(0)) revert InvalidAddress();

        // Use default strategy if none provided
        address poolStrategy = strategy == address(0) ? DEFAULT_STRATEGY : strategy;

        // TODO: In production, this would:
        // 1. Call Allo.createPool() with properly encoded initData
        // 2. Transfer matching funds to the pool
        // 3. Set up pool parameters (registration/allocation timestamps)
        // 4. Configure manager roles

        // For now, this is a placeholder that will be implemented in Phase 1
        poolId = 0; // This would be returned from Allo.createPool()

        emit PoolCreated(poolId, profileId, poolStrategy, token, matchingFunds, metadata);

        return poolId;
    }

    // ====================================
    // ======== ADMIN FUNCTIONS ===========
    // ====================================

    /**
     * @notice Update treasury address
     * @param _newTreasury New treasury address
     */
    function setTreasury(address _newTreasury) external onlyOwner {
        if (_newTreasury == address(0)) revert InvalidAddress();
        address oldTreasury = treasury;
        treasury = _newTreasury;
        emit TreasuryUpdated(oldTreasury, _newTreasury);
    }

    /**
     * @notice Update platform fee percentage
     * @param _newPercentage New fee percentage in basis points
     */
    function setFeePercentage(uint256 _newPercentage) external onlyOwner {
        if (_newPercentage > 10000) revert InvalidFeePercentage();
        uint256 oldPercentage = platformFeePercentage;
        platformFeePercentage = _newPercentage;
        emit FeePercentageUpdated(oldPercentage, _newPercentage);
    }

    /**
     * @notice Transfer ownership
     * @param newOwner New owner address
     */
    function transferOwnership(address newOwner) external onlyOwner {
        if (newOwner == address(0)) revert InvalidAddress();
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    // ====================================
    // ========= VIEW FUNCTIONS ===========
    // ====================================

    /**
     * @notice Get factory version
     * @return Version string
     */
    function version() external pure returns (string memory) {
        return "1.0.0";
    }
}
