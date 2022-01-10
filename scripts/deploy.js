// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {

  // APEX Token Supply
  const initSupply = 1e12
  
  // Deploy Staking Token
  const Apex = await hre.ethers.getContractFactory("Apex")
  const apex = await Apex.deploy(initSupply)

  await apex.deployed()

  console.log("Apex token deployed at: " + apex.address)

  // Staking Cooldown
  const cooldown = 604800
  
  // Deploy Staking Token
  const Staking = await hre.ethers.getContractFactory("Staking")
  const staking = await Staking.deploy(apex.address, cooldown)

  await staking.deployed()

  console.log("Staking Contract deployed at: " + staking.address)

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});
