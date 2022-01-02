// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract sApex is ERC20, Ownable {

    // STORAGE VARIABLES
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

    // MODIFIER

    // Constructor
    constructor(address apex) ERC20("staked Apex", "sAPEX") {
        // Init APEX Contract
        require(apex != address(0), "Error: Invalid address");
        APEX = IERC20(apex);
    }

    // STAKING FUNCTIONALITY
    function stake(uint256 _amount) public returns (bool) {
        // Check Amount
        uint256 apexBalance = APEX.balanceOf(_msgSender());
        require(_amount <= apexBalance, "Error: Insufficient tokens.");
        // Add to staking positions.
        stakingPositions[msg.sender] = stakingInfo({
            amount: _amount,
            cooldown: COOLDOWN_PERIOD,
            cooldownShare: 0
        });
        // Transfer APEX and mint sAPEX
        APEX.transferFrom(msg.sender, address(this), _amount);
        _mint(msg.sender, _amount);
        // Emit stake event
        emit Stake(_amount, msg.sender);

        return true;
    }
    

}