// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {

  const initSupply = 1e12
  
  // Deploy Staking Token
  const Apex = await hre.ethers.getContractFactory("Apex")
  const apex = await Apex.deploy(initSupply)

  await apex.deployed()

  console.log("Apex token deployed at: " + apex.address)
  
  // Deploy Staking Contract
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});
