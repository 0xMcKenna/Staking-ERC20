// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Staking is Ownable {

    // STORAGE VARIABLES
    struct stakingInfo {
        uint256 amount; // staked amount
        uint256 cooldown; // cooldown time
        uint256 cooldownShare; // amount in cooldown
    }

    mapping(address => stakingInfo) public stakingPositions;

    // APEX Token
    address public apex;

    // Unbonding time
    uint256 public COOLDOWN_PERIOD;

    // EVENTS
    event Stake(uint256 indexed amount, address indexed staker);
    event Cooldown(uint256 indexed share, address indexed unstaker);
    event Withdraw(uint256 indexed share, address indexed unstaker);

    // Initiialize
    constructor(address _apex, uint256 _cooldown) {
        // Init staking token
        require(address(_apex) != address(0), "Invalid input.");
        apex = _apex;
        // Set cooldown period
        COOLDOWN_PERIOD = _cooldown;
    }

    // Owner Functionality
    function setCooldown(uint256 newCooldown) external onlyOwner returns (bool) {
        require(newCooldown > 0 && newCooldown != COOLDOWN_PERIOD, "Error: Invalid Cooldown");
        COOLDOWN_PERIOD = newCooldown;

        return true;
    }

    // STAKING FUNCTIONALITY
    function stake(uint256 _amount) external returns (bool) {
        // Checks
        uint256 balance = IERC20(apex).balanceOf(msg.sender);
        require(_amount > 0, "Error: Invalid stake amount");
        require(_amount <= balance, "Error: Insufficient funds");

        // Set stake amount
        stakingPositions[msg.sender] = stakingInfo({
            amount: _amount,
            cooldown: 0,
            cooldownShare: 0
        });

        // Transfer APEX
        IERC20(apex).transferFrom(msg.sender, address(this), _amount);

        return true;
    }

    function cooldown(uint256 unstakeShare) external returns (bool) {
        // Checks
        uint256 stakingBalance = stakingPositions[msg.sender].amount;
        require(unstakeShare > 0, "Error: Invalid unstake amount");
        require(unstakeShare <= stakingBalance, "Error: Insufficient Balance");

        // Set Cooldown Time
        unchecked {
            stakingPositions[msg.sender].cooldown = block.timestamp + COOLDOWN_PERIOD;
        }

        if(unstakeShare == stakingBalance) {
            stakingPositions[msg.sender].amount = 0;
            stakingPositions[msg.sender].cooldownShare = stakingBalance;
        }
        else {
            unchecked {
                stakingPositions[msg.sender].amount = stakingBalance - unstakeShare;
                stakingPositions[msg.sender].cooldownShare = unstakeShare;
            }
        }

        return true;
    }

    function withdraw(uint256 withdrawAmount) external returns (bool) {
        // Checks
    }

    // Returns current staking balance
    function stakeOf(address staker) public view returns (uint256) {
        return stakingPositions[staker].amount;
    }

    // Returns APEX balance of the staking contract
    function apexBalance() public view returns (uint256) {
        return IERC20(apex).balanceOf(address(this));
    }

}
