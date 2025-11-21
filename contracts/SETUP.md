# Foundry Setup Guide

This guide will help you set up Foundry and the Such.Fund contracts development environment.

## Step 1: Install Foundry

### On Linux/macOS:

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### On Windows:

Download and run the installer from: https://github.com/foundry-rs/foundry/releases

Or use WSL2 and follow the Linux instructions.

### Verify Installation

```bash
forge --version
cast --version
anvil --version
```

You should see version output for each tool.

## Step 2: Install Dependencies

From the `contracts/` directory:

```bash
cd contracts

# Install OpenZeppelin contracts
forge install OpenZeppelin/openzeppelin-contracts@v4.9.5 --no-commit

# Install OpenZeppelin upgradeable contracts
forge install OpenZeppelin/openzeppelin-contracts-upgradeable@v4.9.5 --no-commit

# Install Forge standard library
forge install foundry-rs/forge-std --no-commit

# Install Solady (gas-optimized libraries)
forge install vectorized/solady --no-commit

# Install Allo v2 (for reference/testing)
forge install allo-protocol/allo-v2 --no-commit
```

## Step 3: Configure Environment

```bash
cp .env.example .env
```

Edit `.env` and add your values:
- RPC URLs (can use public ones or get from Alchemy/Infura)
- Your deployer private key (NEVER commit this!)
- Arbiscan API key (for contract verification)

## Step 4: Build Contracts

```bash
forge build
```

You should see output like:
```
[⠢] Compiling...
[⠆] Compiling 1 files with 0.8.19
[⠰] Solc 0.8.19 finished in 1.23s
Compiler run successful!
```

## Step 5: Run Tests

```bash
forge test
```

You should see all tests passing:
```
Running 15 tests for test/SuchFundPoolFactory.t.sol:SuchFundPoolFactoryTest
[PASS] test_Constructor() (gas: 1234)
[PASS] test_SetTreasury() (gas: 2345)
...
Test result: ok. 15 passed; 0 failed; finished in 10.34ms
```

## Step 6: Test Deployment (Local)

Start a local testnet:
```bash
anvil
```

In another terminal, deploy:
```bash
forge script script/Deploy.s.sol:DeployScript --rpc-url http://localhost:8545 --broadcast
```

## Common Issues & Solutions

### Issue: "command not found: forge"

**Solution:** Make sure Foundry is in your PATH. Run:
```bash
source ~/.bashrc  # or ~/.zshrc
```

### Issue: "failed to resolve dependencies"

**Solution:** Make sure git is installed and you have internet access. Try:
```bash
forge install --force
```

### Issue: "compilation failed"

**Solution:** Check Solidity version:
```bash
forge --version
```
Should show solc 0.8.19 or compatible.

### Issue: "RPC connection failed"

**Solution:** Check your RPC URL in `.env`. Try a public RPC:
```
ARBITRUM_SEPOLIA_RPC_URL=https://sepolia-rollup.arbitrum.io/rpc
```

## Next Steps

Once setup is complete:

1. Read the [contracts README](./README.md)
2. Explore the sample contract: `src/SuchFundPoolFactory.sol`
3. Check out the tests: `test/SuchFundPoolFactory.t.sol`
4. Review deployment scripts: `script/Deploy.s.sol`

## Resources

- [Foundry Book](https://book.getfoundry.sh/) - Complete Foundry documentation
- [Foundry GitHub](https://github.com/foundry-rs/foundry) - Source code & issues
- [Solidity Docs](https://docs.soliditylang.org/) - Solidity language reference

## Getting Help

If you run into issues:
1. Check the [Foundry Book](https://book.getfoundry.sh/)
2. Search [Foundry GitHub Issues](https://github.com/foundry-rs/foundry/issues)
3. Ask in [Foundry Telegram](https://t.me/foundry_rs)
