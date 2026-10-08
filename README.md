# 🪙 Lperthui42Token (Tokenizer)

**Lperthui42Token** is a customizable **ERC20 token** with a **multi-signature mint** mechanism, developed at **42 School**. It is written in Solidity for Ethereum and deployed on **BNB Chain** (testnet).
New tokens can only be created once a predefined number of signers has approved the request.

---

## ✨ Main features

- **ERC20 standard**: inherits OpenZeppelin's audited `ERC20` implementation for compatibility and security.
- **Ownership**: uses `Ownable` to designate a single owner allowed to propose mints.
- **Multi-signature mint**: each mint request must be approved by a set number of signers before being executed.
- **Mint tracking**: every request is stored with its details (recipient, amount, number of approvals, execution status), so signers can review it before signing.

| Info | Value |
|---|---|
| Name | Lperthui42Token |
| Symbol | LT42 |
| Decimals | 18 |

---

## ⛓️ Why BNB Chain

1. **Recommended by the subject**, because of its reach and its partnership with 42.
2. **Easy to test**: the BNB testnet lets you test the contract before any mainnet deployment.
3. **Free test tokens**: the BNB Chain faucet provides tBNB in a few clicks.

---

## 🧱 Technical choices

### Solidity 0.8.20
Solidity is the standard language for smart contracts on Ethereum and EVM-compatible chains such as BNB Chain. Version 0.8.x adds **built-in overflow and underflow checks**, and the language is supported by all the usual tools (Remix, Hardhat, Truffle) and wallets (MetaMask).

### OpenZeppelin
A battle-tested library for secure smart contracts. Inheriting `ERC20` and `Ownable`:
- avoids common token vulnerabilities (balance handling, overflows…);
- saves time with tested, standardized functions;
- provides ownership and access control out of the box.

### Multi-signature mint
Requiring several signatures to mint:
- prevents a malicious owner from issuing tokens at will;
- guarantees that several trusted parties validate each token creation.

### Token scale
Amounts are multiplied by `10 ** 18` to follow the ERC20 convention (1 token = 10^18 base units) and stay compatible with wallets like MetaMask.

---

## 🔧 Contract API

| Function | Description |
|---|---|
| `constructor(initialSupply, signers, _requiredSignatures)` | Mints `initialSupply` to the deployer, who becomes the owner, and sets the signers |
| `proposeMint(address to, uint256 amount)` | Owner only: creates a mint request |
| `approveMint(uint256 id)` | Signers only: approves a request; it is executed once enough signatures are collected |
| `getNumberOfMintRequest()` | Returns the number of mint requests |
| `getMintRequest(uint256 id)` | Returns the details of a request |
| `amITheOwner()` | Checks whether the caller is the owner |

---

## 🚀 Deployment

Step-by-step instructions (Remix, MetaMask, verification on BscScan) are in [`deployment/deployment.txt`](deployment/deployment.txt), and the full documentation is in [`documentation/documentation.txt`](documentation/documentation.txt).

---

## 🛠️ Tech stack

- Solidity 0.8.20
- OpenZeppelin (`ERC20`, `Ownable`)
- Remix, MetaMask, BscScan
- BNB Chain testnet
