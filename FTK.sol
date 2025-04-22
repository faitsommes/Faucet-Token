// License

// SPDX-License-Identifier: LGPL-3.0-only

// Version

pragma solidity ^0.8.0;

// Libraries

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// Contract

contract FTK is ReentrancyGuard {
    
    using SafeERC20 for IERC20;

    IERC20 public token;
    address public owner; // For onlyOwner()
    uint256 public immutable deploymentDate; // Needed for calculating amount of tokens recieved.
    uint256 public constant IN_AMOUNT = 100 * 1e18; // Starts with 100 tokens.
    uint256 public constant COOLDOWN = 24 hours;

    mapping (address => uint256) public lastRequest;

    event TokenRequest(address indexed user, uint256 moment);

    bool public tokenSet = false;

    // Modifier for avoiding another person to set the Token Address.
    modifier onlyOwner() {
        require(owner == msg.sender, "You need to be the owner.");
        _;
    }

    // Modifier for avoiding Token Address to bet set more than once.
    modifier onlyOnce() {
        require(!tokenSet, "Token address already set.");
        _;
        tokenSet = true;
    }

    constructor() {
        owner = msg.sender;
        deploymentDate = block.timestamp;
    }

    // For setting the token address. It can only be used once and by the owner.
    function setTokenAddress(IERC20 _token) external onlyOwner onlyOnce {
        token = _token;
    }


    function getAmount() public view returns (uint256){
        uint256 FaucetLive = block.timestamp - deploymentDate;
        uint256 monthsElapsed = FaucetLive / 30 days;

        uint256 amount = IN_AMOUNT;

        // Calculate the number of tokens to be given according to the number of months elapsed.
        for (uint256 i = 0; i < monthsElapsed; ++i) {
            amount = amount * 9/10; // Reduce number of tokens by 10%.
        }
        
        // Avoid giving < 1 wei
        if (amount == 0) {
            return 1;
        }

        return amount;
    }

    function requestTokens() external nonReentrant {
        
        uint256 amount = getAmount();
        require(block.timestamp - lastRequest[msg.sender] >= COOLDOWN, "You have to wait 24 hours to claim more tokens.");
        require(token.balanceOf(address(this)) >= amount, "Faucet empty");
        
        lastRequest[msg.sender] = block.timestamp;
        token.safeTransfer(msg.sender, amount);

        emit TokenRequest(msg.sender, block.timestamp);
    
    }



}