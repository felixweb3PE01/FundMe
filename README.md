# FundMe Solidity Smart Contract

## Table of Contents
1. [Project Overview](#project-overview)  
2. [Features](#features)  
3. [How It Works](#how-it-works)  
4. [Key Components](#key-components)  
5. [Installation & Usage](#installation--usage)  
6. [Functions Explained](#functions-explained)  
7. [Security & Best Practices](#security--best-practices)  
8. [Future Improvements](#future-improvements)  
9. [References](#references)  

---

## Project Overview
**FundMe** is a decentralized crowdfunding smart contract built in Solidity for the Ethereum blockchain. It allows users to contribute ETH to a contract, enforces a minimum contribution in USD terms using Chainlink price feeds, and allows only the contract owner to withdraw the funds.  

This project is ideal for understanding:  
- Interacting with Chainlink oracles  
- Owner-only access control  
- Safe ETH transfers  
- Solidity best practices  

---

## Features
- **ETH Contributions:** Users can fund the contract with ETH.  
- **Minimum USD Requirement:** Contributions are validated against a $5 minimum using live ETH/USD prices.  
- **Chainlink Price Feed Integration:** Ensures USD-based funding thresholds.  
- **Owner-only Withdrawals:** Funds can only be withdrawn by the deployer (owner).  
- **Fallback & Receive Functions:** Accept ETH sent directly to the contract.  
- **Gas-efficient Data Tracking:** Keeps track of funders and their contributions.  

---

## How It Works
1. Users call the `fund()` function to send ETH.  
2. The contract converts the ETH amount to USD using Chainlink’s price feed.  
3. If the USD equivalent meets the minimum requirement, the sender is added to the funders list and their contribution is recorded.  
4. The owner can call `withdraw()` to transfer all funds safely to their wallet.  
5. Fallback and receive functions allow direct ETH transfers to automatically fund the contract.  

---

## Key Components
- **Contract:** `FundMe.sol`  
- **Library:** `PriceConverter.sol` (handles conversion from ETH to USD)  
- **Chainlink Aggregator:** For real-time ETH/USD price  
- **Mappings & Arrays:**  
  - `addressToAmountFunded`: tracks how much each address has contributed  
  - `funders`: array of all contributors  
- **Modifiers:**  
  - `cond` (or `onlyOwner`) restricts withdrawals to the contract owner  

---

## Installation & Usage
1. Clone this repository:  
```bash
git clone <repo-link>
cd FundMe
