# Such.Fund Development Roadmap

> **Target MVP:** 4 weeks from project start
> **Target Launch:** 10 weeks from project start

---

## 📋 Table of Contents
- [Overview](#overview)
- [Phase 0: Foundation (Week 0)](#phase-0-foundation-week-0)
- [Phase 1: MVP Development (Weeks 1-4)](#phase-1-mvp-development-weeks-1-4)
- [Phase 2: Enhanced Features (Weeks 5-8)](#phase-2-enhanced-features-weeks-5-8)
- [Phase 3: Launch Preparation (Weeks 9-10)](#phase-3-launch-preparation-weeks-9-10)
- [Phase 4: Post-Launch (Weeks 11+)](#phase-4-post-launch-weeks-11)
- [Milestones & Success Criteria](#milestones--success-criteria)

---

## Overview

This roadmap outlines the development path for Such.Fund from initial setup to mainnet launch and beyond. Each phase builds upon the previous one, with clear milestones and deliverables.

### Key Principles
- **Iterative Development:** Ship early, iterate based on feedback
- **Testnet First:** Test everything thoroughly before mainnet
- **Security Focus:** Audit before handling real funds
- **User-Centric:** Focus on UX at every stage

---

## Phase 0: Foundation (Week 0)

> **Goal:** Set up development environment and project structure

### 0.1 Development Environment Setup
- [ ] Install Foundry (forge, cast, anvil)
  ```bash
  curl -L https://foundry.paradigm.xyz | bash
  foundryup
  ```
- [ ] Install Node.js 20+ and npm/yarn
- [ ] Install PostgreSQL 15+
- [ ] Install Git and configure SSH keys
- [ ] Set up code editor (VSCode with Solidity/TypeScript extensions)

### 0.2 Project Structure
- [ ] Create `contracts/` directory for custom smart contracts
- [ ] Create `backend/` directory for API server
- [ ] Create `frontend/` directory for Next.js app
- [ ] Create `scripts/` directory for deployment/utility scripts
- [ ] Create `docs/` directory for additional documentation
- [ ] Initialize git submodules if needed

### 0.3 Tool Configuration
- [ ] Set up Foundry project in `contracts/`
  ```bash
  cd contracts && forge init
  ```
- [ ] Configure `.env.example` with required environment variables
- [ ] Set up Hardhat alongside Foundry for deployment scripts
- [ ] Configure Prettier and ESLint for code formatting
- [ ] Set up pre-commit hooks (optional)

### 0.4 Dependencies Installation
- [ ] Install OpenZeppelin contracts
- [ ] Install Solady libraries
- [ ] Clone allo-v2 reference repository
- [ ] Install frontend dependencies (wagmi, viem, etc.)

**Milestone 0:** ✅ Development environment ready, project structure in place

---

## Phase 1: MVP Development (Weeks 1-4)

> **Goal:** Build and deploy a working end-to-end quadratic funding round on testnet

---

### Week 1: Smart Contracts & Testnet Deployment

#### 1.1 Smart Contract Development
- [ ] Study existing Allo contracts in detail
  - [ ] Read Registry.sol implementation
  - [ ] Read Allo.sol implementation
  - [ ] Read DonationVotingMerkleDistributionVaultStrategy.sol
  - [ ] Understand initialization parameters

- [ ] Create `SuchFundPoolFactory.sol` (Optional wrapper)
  - [ ] Define pool creation interface
  - [ ] Add Such.Fund-specific metadata
  - [ ] Implement initialization helpers
  - [ ] Write unit tests

- [ ] Create deployment scripts
  - [ ] Script to verify Allo deployments on Arbitrum Sepolia
  - [ ] Script to create test pool
  - [ ] Script to register test recipients
  - [ ] Script to allocate test funds

#### 1.2 Testnet Setup
- [ ] Get Arbitrum Sepolia testnet ETH from faucet
- [ ] Verify Allo Protocol deployments on Arbitrum Sepolia
  - Registry: `0x4AAcca72145e1dF2aeC137E1f3C5E3D75DB8b5f3`
  - Allo: `0x1133eA7Af70876e64665ecD07C0A0476d09465a1`
  - Strategy: `0x787eC93Dd71a90563979417879F5a3298389227f`

- [ ] Deploy custom contracts (if any) to testnet
  - [ ] Deploy using Foundry scripts
  - [ ] Verify contracts on Arbiscan
  - [ ] Document contract addresses

#### 1.3 Manual Testing
- [ ] Create a test profile in Registry
- [ ] Create a test funding pool (round)
- [ ] Register 3 test projects as recipients
- [ ] Make test allocations from multiple wallets
- [ ] Verify events are emitted correctly

**Week 1 Deliverables:**
- ✅ Smart contracts deployed to testnet
- ✅ Test pool created successfully
- ✅ Manual E2E flow works

---

### Week 2: Backend Foundation

#### 2.1 Database Setup
- [ ] Set up PostgreSQL database (local or Supabase)
- [ ] Create database schema from ARCHITECTURE.md
  - [ ] `projects` table
  - [ ] `rounds` table
  - [ ] `applications` table
  - [ ] `contributions` table
  - [ ] `distributions` table
  - [ ] `passport_scores` table

- [ ] Create database migrations
- [ ] Seed test data

#### 2.2 Event Indexer
- [ ] Choose indexing approach:
  - Option A: The Graph subgraph (recommended)
  - Option B: Custom indexer with Viem

- [ ] If using The Graph:
  - [ ] Initialize subgraph project
  - [ ] Define schema.graphql
  - [ ] Write event handlers for:
    - `PoolCreated`
    - `Registered`
    - `Allocated`
    - `RecipientStatusUpdated`
    - `Distributed`
    - `Claimed`
  - [ ] Deploy subgraph to Subgraph Studio
  - [ ] Test querying events

- [ ] If using custom indexer:
  - [ ] Set up Viem client
  - [ ] Write event listeners
  - [ ] Store events in database
  - [ ] Handle reorgs

#### 2.3 API Server Setup
- [ ] Initialize Express.js/Fastify project
- [ ] Set up TypeScript configuration
- [ ] Create database connection pool
- [ ] Implement basic endpoints:
  - [ ] `GET /api/health` - Health check
  - [ ] `GET /api/rounds` - List rounds
  - [ ] `GET /api/rounds/:id` - Round details
  - [ ] `GET /api/projects` - List projects
  - [ ] `GET /api/projects/:id` - Project details
  - [ ] `GET /api/contributions/:round` - Round contributions

- [ ] Set up CORS and security middleware
- [ ] Add request logging
- [ ] Write API tests

#### 2.4 QF Calculation Engine
- [ ] Create calculation module
  - [ ] Fetch contributions from database/subgraph
  - [ ] Group by project
  - [ ] Calculate square roots
  - [ ] Apply quadratic formula
  - [ ] Distribute matching pool proportionally

- [ ] Create Merkle tree generator
  - [ ] Use OpenZeppelin Merkle tree library
  - [ ] Generate tree from allocations
  - [ ] Store proofs in database

- [ ] Write calculation tests
  - [ ] Test with mock data
  - [ ] Verify against known results
  - [ ] Test edge cases (0 contributions, 1 contributor, etc.)

**Week 2 Deliverables:**
- ✅ Database schema implemented
- ✅ Event indexer running
- ✅ API server with basic endpoints
- ✅ QF calculation engine working

---

### Week 3: Frontend MVP

#### 3.1 Next.js Setup
- [ ] Initialize Next.js 14 project with App Router
  ```bash
  npx create-next-app@latest frontend
  ```
- [ ] Install dependencies:
  - [ ] wagmi, viem, TanStack Query
  - [ ] RainbowKit or ConnectKit
  - [ ] TailwindCSS
  - [ ] shadcn/ui components

- [ ] Configure wagmi and chains
  - [ ] Add Arbitrum Sepolia
  - [ ] Configure RPC providers
  - [ ] Set up wallet connectors

#### 3.2 Core Pages
- [ ] **Landing Page (`/`)**
  - [ ] Hero section explaining QF
  - [ ] How it works section
  - [ ] CTA to browse rounds
  - [ ] Footer with links

- [ ] **Rounds List (`/rounds`)**
  - [ ] Fetch rounds from API
  - [ ] Display as cards with:
    - Round name
    - Status (active/ended)
    - Matching pool size
    - End date
  - [ ] Filter by status
  - [ ] Search functionality

- [ ] **Round Details (`/rounds/[id]`)**
  - [ ] Display round information
  - [ ] Show matching pool
  - [ ] Show timeline (registration/allocation dates)
  - [ ] List participating projects
  - [ ] Show total contributions

- [ ] **Project List (`/rounds/[id]/projects`)**
  - [ ] Grid/list view of projects
  - [ ] Project cards with:
    - Logo
    - Name
    - Short description
    - Total raised
    - Estimated match
  - [ ] Search and filter

- [ ] **Project Details (`/projects/[id]`)**
  - [ ] Full project information
  - [ ] Team members
  - [ ] Funding goal
  - [ ] Current contributions
  - [ ] Contribution form
  - [ ] List of contributors (anonymous or public)

#### 3.3 Wallet Integration
- [ ] Implement wallet connection
  - [ ] Connect button in header
  - [ ] Show connected address
  - [ ] Network switcher (ensure on Arbitrum Sepolia)
  - [ ] Disconnect functionality

- [ ] Add wallet state management
  - [ ] Handle connection errors
  - [ ] Display balance
  - [ ] Show pending transactions

#### 3.4 Donation Flow
- [ ] **Donation Modal/Form**
  - [ ] Amount input (ETH or supported tokens)
  - [ ] Real-time matching estimate
  - [ ] Token approval (if ERC20)
  - [ ] Allocation transaction

- [ ] Implement donation transaction
  - [ ] Use wagmi to call `allocate()` on Strategy contract
  - [ ] Handle Permit2 signature
  - [ ] Show transaction status
  - [ ] Confirmation screen

- [ ] After donation
  - [ ] Show success message
  - [ ] Display contribution in history
  - [ ] Update UI with new totals

#### 3.5 UI Components
- [ ] Build reusable components:
  - [ ] Button, Input, Card (shadcn/ui)
  - [ ] ProjectCard component
  - [ ] RoundCard component
  - [ ] ContributionHistory component
  - [ ] MatchingEstimator component
  - [ ] TransactionStatus component
  - [ ] WalletButton component

**Week 3 Deliverables:**
- ✅ Frontend connected to testnet
- ✅ Users can browse rounds and projects
- ✅ Donation flow works end-to-end

---

### Week 4: Integration & Testing

#### 4.1 Gitcoin Passport Integration
- [ ] Install Gitcoin Passport SDK
  ```bash
  npm install @gitcoinco/passport-sdk-scorer
  ```
- [ ] Set up Passport Scorer API key
- [ ] Create passport verification flow
  - [ ] Prompt user to verify on first donation
  - [ ] Fetch passport score
  - [ ] Cache score in database
  - [ ] Show score in UI

- [ ] Implement minimum score requirement
  - [ ] Block donations below threshold (e.g., 20)
  - [ ] Show helpful error message
  - [ ] Link to Gitcoin Passport to improve score

#### 4.2 End-to-End Testing
- [ ] **Test Round Creation**
  - [ ] Create round via script/admin interface
  - [ ] Verify pool appears on frontend
  - [ ] Check all metadata displays correctly

- [ ] **Test Project Registration**
  - [ ] Register 5 test projects
  - [ ] Verify projects appear on frontend
  - [ ] Test accept/reject flow

- [ ] **Test Donation Flow**
  - [ ] Donate from 10 different wallets
  - [ ] Vary amounts ($1, $5, $10, $50, $100)
  - [ ] Verify transactions succeed
  - [ ] Check database records contributions

- [ ] **Test QF Calculation**
  - [ ] Run calculation engine manually
  - [ ] Verify matching amounts are correct
  - [ ] Generate Merkle tree
  - [ ] Verify proofs

- [ ] **Test Distribution**
  - [ ] Upload Merkle root to contract
  - [ ] Call distribute() with proofs
  - [ ] Verify projects can claim funds
  - [ ] Check final balances

#### 4.3 Bug Fixes & Polish
- [ ] Fix any issues found in testing
- [ ] Improve error messages
- [ ] Add loading states
- [ ] Optimize performance
- [ ] Mobile responsiveness
- [ ] Accessibility improvements

#### 4.4 Documentation
- [ ] Write user guide
  - [ ] How to connect wallet
  - [ ] How to donate to projects
  - [ ] How to register a project
  - [ ] How to claim funds

- [ ] Write developer documentation
  - [ ] API reference
  - [ ] Smart contract interfaces
  - [ ] Database schema
  - [ ] Deployment instructions

- [ ] Create demo video
  - [ ] Screen recording of full flow
  - [ ] Upload to YouTube/Loom

**Week 4 Deliverables:**
- ✅ MVP fully functional on testnet
- ✅ Gitcoin Passport integrated
- ✅ E2E testing complete
- ✅ Documentation written

**Milestone 1: MVP Complete** 🎉
- Working QF platform on testnet
- Users can donate to projects
- Matching calculation works
- Sybil resistance implemented

---

## Phase 2: Enhanced Features (Weeks 5-8)

> **Goal:** Add advanced features, admin tools, and polish the UX

---

### Week 5: Project Management

#### 5.1 Project Profile Pages
- [ ] Enhanced project detail page
  - [ ] Rich text editor for description (Markdown)
  - [ ] Image gallery
  - [ ] Team member profiles
  - [ ] Social links (Twitter, Discord, GitHub)
  - [ ] Milestones section
  - [ ] Updates feed

- [ ] Project dashboard (`/dashboard/project`)
  - [ ] View application status
  - [ ] See contributions received
  - [ ] Update project information
  - [ ] Claim allocated funds
  - [ ] Download contributor list

#### 5.2 Project Application Flow
- [ ] **Application Form**
  - [ ] Multi-step form
    - Step 1: Basic info (name, description)
    - Step 2: Team & links
    - Step 3: Funding goals
    - Step 4: Review & submit
  - [ ] Image uploads (logo, banner)
  - [ ] Form validation
  - [ ] Save as draft
  - [ ] Submit application

- [ ] Backend for applications
  - [ ] `POST /api/projects` - Create project
  - [ ] `PUT /api/projects/:id` - Update project
  - [ ] `POST /api/projects/:id/apply/:roundId` - Apply to round
  - [ ] Store metadata on IPFS (optional)

#### 5.3 Contributor Experience
- [ ] **User Dashboard (`/dashboard`)**
  - [ ] Contribution history
  - [ ] Supported projects
  - [ ] Estimated matching generated
  - [ ] Passport score display
  - [ ] Donation receipts

- [ ] Contribution tracking
  - [ ] Real-time updates
  - [ ] Email notifications (optional)
  - [ ] Share on social media

**Week 5 Deliverables:**
- ✅ Rich project profiles
- ✅ Application flow implemented
- ✅ User dashboard complete

---

### Week 6: Round Management & Admin Tools

#### 6.1 Admin Interface
- [ ] **Admin Dashboard (`/admin`)**
  - [ ] Overview of all rounds
  - [ ] Platform statistics
  - [ ] Recent activity
  - [ ] User management (if needed)

- [ ] **Create Round UI (`/admin/rounds/create`)**
  - [ ] Multi-step form
    - Step 1: Basic info (name, description)
    - Step 2: Funding details (matching pool, token)
    - Step 3: Timeline (registration/allocation dates)
    - Step 4: Settings (strategy, eligibility)
    - Step 5: Review & deploy
  - [ ] Call Allo.createPool() on submission
  - [ ] Show transaction status
  - [ ] Redirect to round management page

#### 6.2 Round Management
- [ ] **Manage Round (`/admin/rounds/[id]`)**
  - [ ] Round overview dashboard
  - [ ] Edit round details
  - [ ] Manage timeline (extend dates)
  - [ ] View all applications
  - [ ] Approve/reject projects
  - [ ] View live contributions
  - [ ] Monitor matching estimates

- [ ] **Application Review Interface**
  - [ ] List all pending applications
  - [ ] Project details popup
  - [ ] Approve/reject with reason
  - [ ] Batch operations
  - [ ] Call reviewRecipients() on contract

#### 6.3 Distribution Management
- [ ] **Distribution Interface**
  - [ ] Button to calculate matching
  - [ ] Display calculation results
  - [ ] Show Merkle root
  - [ ] Upload Merkle root to contract
  - [ ] Distribute funds to projects
  - [ ] Track claim status

- [ ] Automated distribution flow
  - [ ] Run calculation on round end
  - [ ] Generate notifications to projects
  - [ ] Monitor claim transactions

**Week 6 Deliverables:**
- ✅ Admin can create rounds via UI
- ✅ Round management tools complete
- ✅ Project review workflow implemented

---

### Week 7: Analytics & UX Enhancements

#### 7.1 Real-time Matching Estimates
- [ ] Implement matching calculation in frontend
  - [ ] Fetch all contributions for round
  - [ ] Calculate current matching for each project
  - [ ] Display estimated matching on project cards
  - [ ] Update in real-time as contributions come in

- [ ] "What if" calculator
  - [ ] Show how donation amount affects matching
  - [ ] Interactive slider
  - [ ] Visualize impact

#### 7.2 Statistics Dashboard
- [ ] **Round Statistics (`/rounds/[id]/stats`)**
  - [ ] Total contributions
  - [ ] Number of unique contributors
  - [ ] Average contribution size
  - [ ] Matching pool utilization
  - [ ] Charts and graphs (Chart.js/Recharts)

- [ ] **Platform Statistics (`/stats`)**
  - [ ] Total funds allocated (all rounds)
  - [ ] Projects funded
  - [ ] Contributors count
  - [ ] Trending projects
  - [ ] Leaderboards

#### 7.3 UX Improvements
- [ ] Onboarding flow
  - [ ] First-time user tutorial
  - [ ] Interactive walkthrough
  - [ ] Tooltips for complex concepts

- [ ] Search & discovery
  - [ ] Advanced search
  - [ ] Tag/category filtering
  - [ ] Sort by various metrics
  - [ ] Recommended projects

- [ ] Social features
  - [ ] Share project links with OG tags
  - [ ] Twitter/Farcaster integration
  - [ ] Contributor badges/NFTs (optional)

#### 7.4 Notifications
- [ ] Email notifications (optional)
  - [ ] Set up email service (SendGrid/Resend)
  - [ ] Round start/end notifications
  - [ ] Application status updates
  - [ ] Claim reminders

- [ ] In-app notifications
  - [ ] Bell icon with notification count
  - [ ] Notification center
  - [ ] Mark as read

**Week 7 Deliverables:**
- ✅ Real-time matching estimates
- ✅ Analytics dashboards
- ✅ Improved UX and onboarding

---

### Week 8: Security & Optimization

#### 8.1 Security Audit Preparation
- [ ] **Smart Contract Review**
  - [ ] Internal security review
  - [ ] Check for common vulnerabilities
  - [ ] Ensure proper access controls
  - [ ] Test edge cases
  - [ ] Reach out to auditing firms (OpenZeppelin, Trail of Bits, etc.)

- [ ] **Backend Security**
  - [ ] API rate limiting
  - [ ] Input validation and sanitization
  - [ ] SQL injection prevention
  - [ ] XSS protection
  - [ ] CSRF tokens
  - [ ] Secure headers (CSP, etc.)

- [ ] **Frontend Security**
  - [ ] Validate all user inputs
  - [ ] Sanitize displayed data
  - [ ] Secure wallet interactions
  - [ ] No private key handling

#### 8.2 Performance Optimization
- [ ] **Frontend Optimization**
  - [ ] Code splitting
  - [ ] Lazy loading
  - [ ] Image optimization
  - [ ] Bundle size analysis
  - [ ] Lighthouse audit (aim for 90+ score)

- [ ] **Backend Optimization**
  - [ ] Database query optimization
  - [ ] Add indexes
  - [ ] Caching (Redis)
  - [ ] API response compression

- [ ] **Blockchain Optimization**
  - [ ] Batch operations where possible
  - [ ] Gas optimization
  - [ ] Minimize contract calls

#### 8.3 Testing & QA
- [ ] **Automated Testing**
  - [ ] Smart contract tests (Forge)
  - [ ] Backend API tests (Jest/Mocha)
  - [ ] Frontend component tests (Vitest/Jest)
  - [ ] E2E tests (Playwright/Cypress)
  - [ ] Aim for >80% coverage

- [ ] **Load Testing**
  - [ ] API load testing (k6/Artillery)
  - [ ] Database performance testing
  - [ ] Frontend stress testing

- [ ] **User Acceptance Testing**
  - [ ] Internal testing with team
  - [ ] Beta testing with friends/community
  - [ ] Collect feedback
  - [ ] Create bug reports

#### 8.4 Bug Fixes & Polish
- [ ] Fix all critical bugs
- [ ] Fix high-priority bugs
- [ ] Polish UI/UX issues
- [ ] Improve error messages
- [ ] Add helpful loading states
- [ ] Final accessibility review

**Week 8 Deliverables:**
- ✅ Security audit complete (or in progress)
- ✅ Performance optimized
- ✅ Comprehensive test coverage
- ✅ All critical bugs fixed

**Milestone 2: Production-Ready** 🚀
- Platform hardened and secure
- Performance optimized
- Ready for mainnet deployment

---

## Phase 3: Launch Preparation (Weeks 9-10)

> **Goal:** Deploy to mainnet and prepare for public launch

---

### Week 9: Mainnet Deployment

#### 9.1 Pre-deployment Checklist
- [ ] Security audit complete and issues resolved
- [ ] All tests passing
- [ ] Documentation up to date
- [ ] Environment variables configured for production
- [ ] Monitoring tools set up

#### 9.2 Smart Contract Deployment
- [ ] Deploy custom contracts to Arbitrum One
  - [ ] Use deployment scripts
  - [ ] Verify contracts on Arbiscan
  - [ ] Document contract addresses

- [ ] Verify existing Allo deployments on mainnet
  - Registry: `0x4AAcca72145e1dF2aeC137E1f3C5E3D75DB8b5f3`
  - Allo: `0x1133eA7Af70876e64665ecD07C0A0476d09465a1`
  - Strategy: `0x787eC93Dd71a90563979417879F5a3298389227f`

- [ ] Transfer ownership to multisig
  - [ ] Create Gnosis Safe multisig
  - [ ] Add co-founders/advisors as signers
  - [ ] Transfer admin roles to multisig

#### 9.3 Infrastructure Deployment
- [ ] **Database**
  - [ ] Set up production PostgreSQL (Supabase/Neon/RDS)
  - [ ] Run migrations
  - [ ] Set up backups
  - [ ] Configure read replicas (optional)

- [ ] **Backend API**
  - [ ] Deploy to production (Railway/Render/AWS)
  - [ ] Set up environment variables
  - [ ] Configure logging
  - [ ] Test endpoints

- [ ] **Frontend**
  - [ ] Deploy to Vercel/Netlify
  - [ ] Configure custom domain
  - [ ] Set up SSL
  - [ ] Configure environment variables
  - [ ] Test production build

- [ ] **Indexer**
  - [ ] Deploy subgraph to mainnet
  - [ ] Verify indexing works
  - [ ] Monitor sync status

#### 9.4 Monitoring & Alerts
- [ ] **Smart Contract Monitoring**
  - [ ] Set up Tenderly for transaction monitoring
  - [ ] Configure alerts for failed transactions
  - [ ] OpenZeppelin Defender for automation

- [ ] **Application Monitoring**
  - [ ] Set up Sentry for error tracking
  - [ ] Configure Datadog/New Relic for performance
  - [ ] Set up uptime monitoring (UptimeRobot)

- [ ] **Alerts**
  - [ ] Email alerts for critical errors
  - [ ] Slack/Discord alerts
  - [ ] PagerDuty for on-call (optional)

#### 9.5 Final Testing
- [ ] Smoke test all features on mainnet
- [ ] Test with small real funds
- [ ] Verify gas costs are reasonable
- [ ] Check all integrations work (Passport, wallets, etc.)

**Week 9 Deliverables:**
- ✅ Deployed to mainnet
- ✅ Monitoring in place
- ✅ Ready for first real round

---

### Week 10: Launch

#### 10.1 Launch Preparation
- [ ] **Content Creation**
  - [ ] Write launch announcement
  - [ ] Create marketing materials
  - [ ] Prepare social media posts
  - [ ] Record demo videos
  - [ ] Design graphics/memes

- [ ] **Documentation**
  - [ ] User guides
  - [ ] FAQ
  - [ ] Terms of Service
  - [ ] Privacy Policy
  - [ ] Brand guidelines

- [ ] **Community Setup**
  - [ ] Create Twitter account
  - [ ] Set up Discord/Telegram
  - [ ] Create mirror.xyz/blog
  - [ ] Set up support channels

#### 10.2 Pilot Round
- [ ] **Create First Round**
  - [ ] Secure matching pool ($10K-$50K)
    - Reach out to DAOs/protocols
    - Personal funds
    - Ecosystem grants
  - [ ] Set round parameters (2-week duration)
  - [ ] Invite 10-15 quality projects
  - [ ] Create round on platform

- [ ] **Onboard Projects**
  - [ ] Personal outreach
  - [ ] Help with applications
  - [ ] Provide support
  - [ ] Create project profiles

- [ ] **Soft Launch**
  - [ ] Share with close network first
  - [ ] Gather initial feedback
  - [ ] Monitor closely for issues
  - [ ] Fix bugs quickly

#### 10.3 Public Launch
- [ ] **Announcement**
  - [ ] Publish launch post
  - [ ] Share on Twitter/Farcaster
  - [ ] Post in relevant communities (r/ethereum, Crypto Twitter)
  - [ ] Submit to crypto news sites (Decrypt, CoinDesk)

- [ ] **Marketing Push**
  - [ ] Twitter Spaces / podcast appearances
  - [ ] Content marketing (blog posts)
  - [ ] Community partnerships
  - [ ] Influencer outreach (if applicable)

- [ ] **User Acquisition**
  - [ ] Onboard contributors
  - [ ] Support first-time users
  - [ ] Incentivize early contributions (optional)
  - [ ] Create referral program (optional)

#### 10.4 Launch Day
- [ ] Monitor everything closely
- [ ] Be available for support
- [ ] Respond to feedback quickly
- [ ] Engage with community
- [ ] Celebrate! 🎉

**Week 10 Deliverables:**
- ✅ First mainnet round launched
- ✅ Public announcement made
- ✅ Users onboarded

**Milestone 3: Launch Complete** 🎊
- Platform live on mainnet
- First funding round active
- Community building started

---

## Phase 4: Post-Launch (Weeks 11+)

> **Goal:** Iterate, grow, and build towards sustainability

### 11. Growth & Iteration (Ongoing)

#### 11.1 Round Management
- [ ] Complete first round successfully
- [ ] Run post-mortem / retrospective
- [ ] Gather feedback from projects and contributors
- [ ] Launch second round within 2-4 weeks
- [ ] Establish regular round cadence (weekly/monthly)

#### 11.2 Feature Additions
- [ ] Multi-token support (USDC, DAI, etc.)
- [ ] NFT-gated rounds
- [ ] Retroactive funding rounds
- [ ] Milestone-based distributions
- [ ] Project updates/blogging
- [ ] Advanced analytics
- [ ] Mobile app (optional)

#### 11.3 Community Building
- [ ] Grow Twitter following
- [ ] Build Discord community
- [ ] Create content regularly
- [ ] Host AMAs / Twitter Spaces
- [ ] Attend crypto conferences
- [ ] Speak at events

#### 11.4 Business Development
- [ ] Secure more matching pool funds
- [ ] Partner with DAOs and protocols
- [ ] Apply for ecosystem grants (Arbitrum, Optimism, etc.)
- [ ] Explore revenue models
- [ ] Build advisory board

### 12. Expansion (3-6 Months)

#### 12.1 Multi-chain Expansion
- [ ] Deploy to Base
- [ ] Deploy to Optimism
- [ ] Deploy to Polygon
- [ ] Consider non-EVM chains (Solana, Cosmos)

#### 12.2 Advanced Features
- [ ] DAO governance
  - [ ] Create governance token
  - [ ] Set up DAO (Aragon, DAOhaus)
  - [ ] Transition to community ownership

- [ ] Pairwise-bounded QF
  - [ ] Implement connection-oriented cluster match
  - [ ] Improve collusion resistance

- [ ] ZK identity integration
  - [ ] Privacy-preserving Sybil resistance
  - [ ] WorldID integration
  - [ ] ZK proofs for eligibility

#### 12.3 Ecosystem Integrations
- [ ] Integrate with other funding platforms
- [ ] API for external tools
- [ ] Embeddable donation widgets
- [ ] Farcaster frames
- [ ] Lens Protocol integration

### 13. Sustainability (6-12 Months)

#### 13.1 Platform Sustainability
- [ ] Reach break-even on operating costs
- [ ] Build treasury
- [ ] Hire team members (if needed)
- [ ] Establish legal entity (DAO, LLC, or foundation)

#### 13.2 Impact & Metrics
- [ ] Track total funds allocated
- [ ] Measure project success rates
- [ ] Gather impact stories
- [ ] Publish impact reports
- [ ] Measure ecosystem growth

#### 13.3 Long-term Vision
- [ ] Become the default QF platform for crypto
- [ ] Facilitate $10M+ in funding
- [ ] Support 500+ projects
- [ ] Onboard 10,000+ contributors
- [ ] Expand to other funding mechanisms
- [ ] Educate the ecosystem on QF

---

## Milestones & Success Criteria

### 🎯 Milestone 0: Foundation Complete
**Week 0**
- ✅ Dev environment set up
- ✅ Project structure created
- ✅ Dependencies installed

### 🎯 Milestone 1: MVP Complete
**Week 4**
**Success Criteria:**
- ✅ Smart contracts deployed to testnet
- ✅ Backend API functional
- ✅ Frontend can create donations
- ✅ QF calculation works
- ✅ Merkle distribution successful
- ✅ Gitcoin Passport integrated
- ✅ 1 complete test round executed
- ✅ 10+ test projects funded
- ✅ 50+ test contributions made
- ✅ 0 critical bugs

### 🎯 Milestone 2: Production Ready
**Week 8**
**Success Criteria:**
- ✅ Security audit complete
- ✅ Performance optimized
- ✅ >80% test coverage
- ✅ All critical bugs fixed
- ✅ Documentation complete
- ✅ Admin tools functional
- ✅ UX polished

### 🎯 Milestone 3: Mainnet Launch
**Week 10**
**Success Criteria:**
- ✅ Deployed to mainnet
- ✅ First round with $50K+ matching pool
- ✅ 25+ projects participating
- ✅ 200+ unique contributors
- ✅ $10K+ in contributions
- ✅ 95%+ uptime
- ✅ Public announcement made

### 🎯 Milestone 4: Product-Market Fit
**3 Months Post-Launch**
**Success Criteria:**
- ✅ 5+ successful rounds completed
- ✅ $500K+ total matched
- ✅ 100+ projects funded
- ✅ 2,000+ unique contributors
- ✅ Growing organic user acquisition
- ✅ Positive community feedback
- ✅ Break-even on costs

### 🎯 Milestone 5: Ecosystem Leader
**12 Months Post-Launch**
**Success Criteria:**
- ✅ $5M+ total matched
- ✅ 500+ projects funded
- ✅ 10,000+ contributors
- ✅ Multi-chain deployment
- ✅ DAO governance established
- ✅ Sustainable revenue model
- ✅ Recognized brand in crypto

---

## Priority Levels

### P0 - Critical (Must Have for MVP)
- Smart contract deployment
- Donation flow
- QF calculation
- Basic frontend
- Sybil resistance (Gitcoin Passport)

### P1 - High (Should Have for Launch)
- Admin tools
- Project profiles
- Analytics
- Security audit
- Documentation

### P2 - Medium (Nice to Have)
- Advanced analytics
- Email notifications
- Social features
- Mobile optimization

### P3 - Low (Future Enhancements)
- Mobile app
- NFT-gated rounds
- DAO governance
- Multi-chain from day 1

---

## Dependencies & Blockers

### External Dependencies
- Allo Protocol contracts (already deployed ✅)
- Gitcoin Passport API (available ✅)
- Arbitrum RPC (available ✅)
- Auditing firm availability (need to schedule)

### Potential Blockers
- Security audit timeline (4-6 weeks)
- Securing matching pool funds
- RPC rate limits (use Alchemy/Infura)
- Passport API rate limits

### Risk Mitigation
- Start audit process early (Week 6)
- Build matching pool network before launch
- Use premium RPC providers
- Implement caching for Passport scores

---

## Resource Requirements

### Solo Founder (You)
- **Week 1-4:** 40-60 hours/week (MVP sprint)
- **Week 5-8:** 30-40 hours/week (polish)
- **Week 9-10:** 20-30 hours/week (launch prep)
- **Post-launch:** 20-30 hours/week (maintenance + growth)

### If Building a Team
**Recommended Roles:**
- Smart Contract Developer (contract customization)
- Full-stack Developer (frontend + backend)
- Designer (UI/UX)
- Community Manager (Discord, Twitter, support)
- BD/Partnerships (secure matching pools)

### Budget Estimates (If Applicable)
- Security Audit: $15K-$40K
- Infrastructure: $200-$500/month
- Domain/Hosting: $100/month
- Design/Tools: $100-$300/month
- Marketing: Variable
- Total Month 1: ~$20K-$50K + ongoing ~$500-$1K/month

---

## Conclusion

This roadmap provides a clear path from zero to launch in 10 weeks, with continued growth beyond. The key is to:

1. **Start small:** MVP in 4 weeks
2. **Test thoroughly:** Testnet before mainnet
3. **Iterate quickly:** Gather feedback and improve
4. **Focus on UX:** Make it easy for crypto users
5. **Build community:** Engaged users = success

**Next Step:** Start with Phase 0 (Week 0) and work through each task systematically.

Good luck building Such.Fund! 🚀

---

**Questions? Updates?**
Keep this roadmap updated as you progress. Mark completed tasks with ✅ and adjust timelines as needed.
