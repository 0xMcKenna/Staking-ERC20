// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract sApex is ERC20 {

    // Staking token for the staking contract

    constructor() ERC20("Staked-Apex", "sAPX") {

    }

}