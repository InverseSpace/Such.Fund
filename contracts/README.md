# Such.Fund Smart Contracts

Smart contracts for the Such.Fund quadratic funding platform, built on top of Allo Protocol v2.

## Overview

This directory contains:
- Custom smart contracts for Such.Fund
- Deployment scripts
- Tests
- Integration with Allo Protocol

## Structure

```
contracts/
├── src/              # Smart contract source files
├── test/             # Test files
├── script/           # Deployment scripts
├── lib/              # Dependencies (installed via forge)
├── out/              # Compiled contracts (generated)
├── cache/            # Forge cache (generated)
├── foundry.toml      # Foundry configuration
├── remappings.txt    # Import remappings
└── .env.example      # Environment variables template
```

## Prerequisites

### Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

Verify installation:
```bash
forge --version
cast --version
anvil --version
```

## Setup

1. **Clone dependencies:**
   ```bash
   cd contracts
   forge install
   ```

2. **Set up environment variables:**
   ```bash
   cp .env.example .env
   # Edit .env with your values
   ```

3. **Build contracts:**
   ```bash
   forge build
   ```

4. **Run tests:**
   ```bash
   forge test
   ```

## Dependencies

The following dependencies will be installed via `forge install`:

- **OpenZeppelin Contracts** - Standard contract libraries
  ```bash
  forge install OpenZeppelin/openzeppelin-contracts@v4.9.5
  ```

- **OpenZeppelin Upgradeable** - Upgradeable contract patterns
  ```bash
  forge install OpenZeppelin/openzeppelin-contracts-upgradeable@v4.9.5
  ```

- **Forge Standard Library** - Testing utilities
  ```bash
  forge install foundry-rs/forge-std
  ```

- **Solady** - Gas-optimized libraries
  ```bash
  forge install vectorized/solady
  ```

- **Allo v2 (Reference)** - For testing integrations
  ```bash
  forge install allo-protocol/allo-v2
  ```

## Smart Contracts

### Current Contracts

*Coming soon - contracts will be developed in Phase 1*

Planned contracts:
- `SuchFundPoolFactory.sol` - Wrapper for creating pools with Such.Fund defaults
- `SybilDefenseAdapter.sol` - Custom Sybil resistance logic (optional)

### Using Existing Allo Contracts

Such.Fund primarily uses the existing Allo Protocol contracts:

- **Registry**: `0x4AAcca72145e1dF2aeC137E1f3C5E3D75DB8b5f3`
- **Allo**: `0x1133eA7Af70876e64665ecD07C0A0476d09465a1`
- **QF Strategy**: `0x787eC93Dd71a90563979417879F5a3298389227f`

*Same addresses on all supported networks*

## Testing

### Run all tests
```bash
forge test
```

### Run specific test file
```bash
forge test --match-path test/SuchFundPoolFactory.t.sol
```

### Run with verbosity (show logs)
```bash
forge test -vvv
```

### Generate gas report
```bash
forge test --gas-report
```

### Coverage report
```bash
forge coverage
```

## Deployment

### Deploy to Testnet (Arbitrum Sepolia)

1. Ensure `.env` is configured with:
   - `ARBITRUM_SEPOLIA_RPC_URL`
   - `DEPLOYER_PRIVATE_KEY`
   - `ARBISCAN_API_KEY`

2. Run deployment script:
   ```bash
   forge script script/Deploy.s.sol:DeployScript \
     --rpc-url arbitrum_sepolia \
     --broadcast \
     --verify
   ```

### Deploy to Mainnet (Arbitrum One)

```bash
forge script script/Deploy.s.sol:DeployScript \
  --rpc-url arbitrum \
  --broadcast \
  --verify \
  --slow  # Use slower broadcast for mainnet
```

## Verification

Verify contracts on Arbiscan:

```bash
forge verify-contract \
  --chain-id 421614 \
  --compiler-version v0.8.19+commit.7dd6d404 \
  --optimizer-runs 200 \
  <CONTRACT_ADDRESS> \
  src/SuchFundPoolFactory.sol:SuchFundPoolFactory \
  --etherscan-api-key $ARBISCAN_API_KEY
```

## Useful Commands

### Format code
```bash
forge fmt
```

### Check for compilation errors
```bash
forge build --force
```

### Generate documentation
```bash
forge doc
```

### Start local testnet
```bash
anvil
```

### Fork mainnet for testing
```bash
anvil --fork-url https://arb1.arbitrum.io/rpc
```

## Scripts

Scripts in `script/` directory:

- `Deploy.s.sol` - Main deployment script
- `CreatePool.s.sol` - Create a test funding pool
- `RegisterRecipient.s.sol` - Register test recipients
- `AllocateFunds.s.sol` - Make test allocations

Run scripts:
```bash
forge script script/<ScriptName>.s.sol --rpc-url <network>
```

## Interacting with Contracts

### Using Cast (CLI)

Query contract:
```bash
cast call <CONTRACT_ADDRESS> "functionName()" --rpc-url arbitrum_sepolia
```

Send transaction:
```bash
cast send <CONTRACT_ADDRESS> \
  "functionName(uint256)" \
  123 \
  --private-key $DEPLOYER_PRIVATE_KEY \
  --rpc-url arbitrum_sepolia
```

### Using Foundry Scripts

Preferred method for complex interactions - see `script/` directory.

## Security

- **Never commit `.env` file** - Contains private keys
- **Use multisig for admin functions** - Gnosis Safe recommended
- **Audit before mainnet** - External security audit required
- **Test thoroughly** - Aim for >90% coverage
- **Verify on Etherscan** - Always verify deployed contracts

## Resources

- [Foundry Book](https://book.getfoundry.sh/)
- [Allo Protocol Docs](https://docs.allo.gitcoin.co/)
- [Solidity Docs](https://docs.soliditylang.org/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)

## License

AGPL-3.0 (to match Allo Protocol)
