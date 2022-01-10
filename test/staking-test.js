const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

describe("sAPEX", function () {

    const initSupply = 1e12;
    const cooldown = 604800
    let owner;
    let addr1;
    let Apex;
    let apex;
    let Staking;
    let staking;

    beforeEach(async function () {
        // Deploy APEX
        Apex = await ethers.getContractFactory("Apex");
        apex = await Apex.deploy(initSupply);

        // Deploy sAPEX
        Staking = await ethers.getContractFactory("Staking");
        staking = await Staking.deploy(apex.address, cooldown);

        [owner, addr1] = await ethers.getSigners()
    });

    it("Can stake APEX into staking contract", async function () {
        await apex.transfer(addr1.address, 1000)
        // Arrange
        const beforeBalance = await apex.balanceOf(addr1.address)
        const stakeAmount = 100
        expect(beforeBalance.toNumber()).to.equal(1000)

        console.log(beforeBalance)

        // Act
        //const tx = await staking.connect(addr1).stake(stakeAmount, {from: addr1.address})

        // Assert
        const afterBalance = await apex.balanceOf(addr1.address)
        const contractBalance = await apex.apexBalance()

        expect(afterBalance).to.equal(900)
        expect(contractBalance).to.equal(100)
        expect(tx).to.equal(true)
    });

});