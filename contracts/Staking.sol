// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { Initializable } from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Staking is Initializable {

    struct stakingInfo {
        uint256 amount; // staked amount
        uint256 cooldown; // cooldown time
        uint256 cooldownShare; // amount in cooldown
    }

    mapping(address => stakingInfo) public stakingPositions;

    // APEX Token
    IERC20 public APEX;

    // Unbonding time
    uint256 public COOLDOWN_PERIOD = 7 days;

    // EVENTS
    event Stake(uint256 indexed amount, address indexed staker);
    event Cooldown(uint256 indexed share, address indexed unstaker);
    event Withdraw(uint256 indexed share, address indexed unstaker);

    // Initiialize
    function initialize(address _apex) external initializer {
        // Init staking token
        require(address(_apex) != address(0), "Invalid input.");
        APEX = IERC20(_apex);
    }

    // STAKING FUNCTIONALITY
    function stake(uint256 _amount) external {
        // Check Amount
        uint256 apexBalance = APEX.balanceOf(msg.sender);
        require(_amount > 0, "Error: Must be non-zero amount");
        require(_amount <= apexBalance, "Error: Insufficient tokens");
        // Add to staking positions.
        stakingPositions[msg.sender] = stakingInfo({
            amount: _amount,
            cooldown: 0,
            cooldownShare: 0
        });
        // Transfer APEX and mint sAPEX
        APEX.approve(address(this), _amount);
        APEX.transferFrom(msg.sender, address(this), _amount);
        // Emit stake event
        emit Stake(_amount, msg.sender);
    }

    function cooldown(uint256 _amount) external {
        
    }

}