# Such.Fund

> Democratic funding allocation for crypto projects through quadratic funding

## What is Such.Fund?

Such.Fund is a decentralized quadratic funding (QF) platform that enables communities to democratically allocate resources to projects. Built on [Allo Protocol v2](https://allo.gitcoin.co/), it implements a funding mechanism where many small supporters have more influence than a few large donors.

### Why Quadratic Funding?

Traditional funding is plutocratic - whoever has the most money has the most influence. Quadratic funding changes this:

- **$1 from 100 people** generates more matching than **$100 from 1 person**
- The formula rewards projects with broad community support
- Prevents whale dominance while still counting large contributions

**Example:**
```
Project A: 1 donor × $100 = √100 = 10 → matching multiplier
Project B: 10 donors × $10 each = 10 × √10 = 31.6 → matching multiplier

Project B gets 3x more matching despite the same total!
```

## Features

- **Non-custodial donations** - Funds go directly to projects via smart contracts
- **Transparent matching** - All calculations verifiable on-chain via Merkle proofs
- **Sybil resistant** - Gitcoin Passport integration prevents fake accounts
- **Low fees** - Built on Layer 2 (Arbitrum/Base) for $0.10-0.50 transactions
- **Fast rounds** - Weekly or monthly funding rounds vs. quarterly
- **Multi-chain** - Deploy on any EVM L2

## Project Status

**🚧 Under Development - Pre-MVP**

We're currently in the planning and architecture phase. See [ARCHITECTURE.md](./ARCHITECTURE.md) for the complete technical design.

### Roadmap

- [x] Architecture planning
- [x] Allo Protocol exploration
- [ ] Development environment setup
- [ ] Smart contract deployment (testnet)
- [ ] Backend foundation (API + indexer)
- [ ] Frontend MVP
- [ ] End-to-end testing
- [ ] Mainnet launch

**Target MVP:** 4 weeks from project start

## Tech Stack

### Blockchain
- **Protocol:** Allo Protocol v2 (Gitcoin)
- **Strategy:** DonationVotingMerkleDistributionVault
- **Network:** Arbitrum One (mainnet), Arbitrum Sepolia (testnet)
- **Identity:** Gitcoin Passport

### Smart Contracts
- **Language:** Solidity 0.8.19
- **Framework:** Foundry + Hardhat
- **Libraries:** OpenZeppelin, Solady

### Backend
- **Runtime:** Node.js 20 + TypeScript
- **API:** Express.js
- **Database:** PostgreSQL
- **Indexer:** The Graph (subgraph)
- **Web3:** Viem v2

### Frontend
- **Framework:** Next.js 14 (App Router)
- **Styling:** TailwindCSS + shadcn/ui
- **Web3:** wagmi v2 + viem
- **Wallet:** RainbowKit

## Repository Structure

```
Such.Fund/
├── allo-v2/              # Cloned Allo Protocol contracts (reference)
├── contracts/            # Custom smart contracts (to be created)
├── backend/              # API server + QF calculation engine (to be created)
├── frontend/             # Next.js application (to be created)
├── subgraph/             # The Graph indexer (to be created)
├── docs/                 # Additional documentation (to be created)
├── ARCHITECTURE.md       # Complete technical architecture
└── README.md             # This file
```

## How It Works

### For Projects (Grant Recipients)

1. **Register** - Create a profile in the Registry
2. **Apply** - Submit application to a funding round
3. **Get Reviewed** - Round managers approve/reject projects
4. **Receive Donations** - Contributors allocate funds during round
5. **Claim Matching** - After round ends, claim your quadratic match

### For Contributors (Donors)

1. **Verify Identity** - Connect Gitcoin Passport (one-time)
2. **Browse Projects** - Explore projects in active rounds
3. **Donate** - Allocate funds to projects you support
4. **See Impact** - View estimated matching in real-time
5. **Track History** - See all your contributions

### For Round Managers

1. **Create Round** - Define matching pool, dates, eligibility
2. **Review Applications** - Approve projects to participate
3. **Monitor Progress** - Track contributions during round
4. **Calculate Matching** - Run QF calculation engine
5. **Distribute Funds** - Upload Merkle root, enable claims

## Allo Protocol Integration

Such.Fund is built on top of [Allo Protocol](https://allo.gitcoin.co/), which provides:

- **Battle-tested contracts** - $50M+ processed through Gitcoin Grants
- **Multi-chain deployment** - Same addresses on all chains
- **Flexible strategies** - Quadratic funding, direct grants, RFPs, etc.
- **Open source** - AGPL-3.0 license

We use the following deployed contracts:

| Contract | Address | Purpose |
|----------|---------|---------|
| Registry | `0x4AAcca72145e1dF2aeC137E1f3C5E3D75DB8b5f3` | Project registry |
| Allo | `0x1133eA7Af70876e64665ecD07C0A0476d09465a1` | Pool management |
| QF Strategy | `0x787eC93Dd71a90563979417879F5a3298389227f` | Donation voting with Merkle distribution |

*Same addresses on all supported networks (Ethereum, Optimism, Arbitrum, Base, Polygon, etc.)*

## Development Setup

*Coming soon - development environment not yet configured*

Prerequisites:
- Node.js 20+
- Foundry (forge, cast, anvil)
- PostgreSQL 15+
- Git

## Documentation

- [Architecture Overview](./ARCHITECTURE.md) - Complete technical design
- [Allo Protocol Docs](https://docs.allo.gitcoin.co/) - Underlying protocol
- [Quadratic Funding Explained](https://wtfisqf.com/) - Mechanism design

## Contributing

This project is in early development. Contributions welcome once MVP is complete!

### Future Contribution Areas
- Frontend development (React/Next.js)
- Smart contract development (Solidity)
- Backend engineering (Node.js/TypeScript)
- UX/UI design
- Documentation
- Testing & QA

## License

This project will be open source under AGPL-3.0 (to match Allo Protocol).

## Contact & Community

*To be set up:*
- Twitter: TBD
- Discord: TBD
- Email: TBD

## Acknowledgments

- **Gitcoin** - For building Allo Protocol and pioneering QF in crypto
- **Vitalik Buterin & team** - For research on quadratic funding mechanisms
- **Allo Protocol contributors** - For open-source contracts and documentation

---

**Built with ❤️ for the crypto public goods ecosystem**
