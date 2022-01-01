// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { Initializable } from "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract Staking is Initializable {

    // STORAGE VARIABLES

    struct stakingInfo {
        uint256 amount;
        uint256 share;
        uint256 cooldown;
        uint256 cooldownShare;
    }

    // APEX Token
    IERC20 public APEX;
    IERC20 public sAPEX;

    // Unbonding time
    uint256 public constant COOLDOWN_PERIOD = 7 days;

    // EVENTS
    event Stake(uint256 indexed amount, address indexed staker);
    event Cooldown(uint256 indexed share, address indexed unstaker);
    event Withdraw(uint256 indexed share, address indexed unstaker);

    // MODIFIERS

    // CONSTRUCTOR
    
    function initialize() external initializer {
        // Sets addresses for staking tokens
    }

    // Functionality

    // 1 - Stake
    
    function stake(uint256 amount) external {
        // Recieves APEX
        // Mints sAPEX 1:1
    }

    // 2 - Unbond (unbonding time)

    function cooldown(uint256 share) external {
        // 7 day cooldown for x amount of total amount staked
    }

    // 3 - Withdraw

    function withdraw(uint256 share) external {
        // Verifies Cooldown period has ended
        // Burns sAPEX for APEX + APEX Reward
    }

}