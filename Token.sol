// License

// SPDX-License-Identifier: LGPL-3.0-only

// Version

pragma solidity ^0.8.0;

// Libraries

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Contract

contract Token is ERC20 {

    constructor(string memory _name, string memory _symbol, address faucet) ERC20(_name, _symbol) {
        _mint(faucet, 1000000 * 1e18); // Sends 10000 tokens to the faucet address.
    }

}