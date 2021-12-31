// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Apex is ERC20 {

    constructor(uint256 initialSupply) ERC20("Apex", "APX") {
        _mint(msg.sender, initialSupply);
    }

}