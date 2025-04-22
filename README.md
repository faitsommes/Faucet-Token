# Token Faucet Contract

This repository contains the code for deploying your own **Token** and a **Token Faucet** using Solidity. The faucet distributes ERC-20 tokens to users, with a cooldown period between claims and a decreasing token amount over time. The amount given reduces by 10% each month since the contract's deployment, making it a unique token distribution system.

## Features

- **ERC-20 Token Distribution**: Users can request tokens from the faucet.
- **Cooldown Mechanism**: Users must wait 24 hours before requesting tokens again.
- **Decreasing Distribution**: The amount of tokens given decreases by 10% each month.
- **Owner-controlled Token Address**: Only the contract owner can set the token address.
- **Security**: Reentrancy guard to prevent reentrancy attacks.

## Contract Overview

### Faucet Contract (`FTK.sol`)
- The contract distributes ERC-20 tokens to users.
- The amount decreases by 10% for each full month since the contract was deployed.
- A cooldown of 24 hours ensures users can't claim tokens repeatedly in a short period.
- The owner of the contract can set the token address once during deployment.

### Token Contract (`Token.sol`)
- A simple ERC-20 token contract that mints an initial supply to the faucet address.
- This token is used for the faucet distribution.

## Deployment

1. **Deploy the Faucet contract (FTK.sol)**:

2. **Deploy the Token contract (Token.sol)**:
  - Set the name and the symbol of the Token when deploying.
    
3. **Use setTokenAddress() with Token's contract address**

4. **You are ready to go!**
  - Users can request tokens by calling the `requestTokens()` function.
  - The amount of tokens they receive depends on how long the contract has been active (the longer it’s been active, the lower the amount due to the 10% monthly decrease).
  - Users can request tokens once every 24 hours.
