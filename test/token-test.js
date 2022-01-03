const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("sAPEX", function () {

    const initSupply = 1e12;
    let owner;
    let addr1;
    let Apex;
    let apex;
    let sApex;
    let sapex;

    beforeEach(async function () {
        // Deploy APEX
        Apex = await ethers.getContractFactory("Apex");
        apex = await Apex.deploy(initSupply);

        // Deploy sAPEX
        sApex = await ethers.getContractFactory("sApex");
        sapex = await sApex.deploy(apex.address);

        [owner, addr1] = await ethers.getSigners()
    });

    it("Can mint 1000 sAPEX", async function () {
        // Fund address 1 
        await apex.transfer(addr1.address, 1000);

        const initBalance = await apex.balanceOf(addr1.address);
        expect(initBalance).to.be.equal(1000)
        
        // Stake
        await sapex.connect(addr1).stake(100);

        // Verify Balances
        //const apexBalance = await apex.balanceOf(addr1.address)
        //const sapexBalance= await sapex.balanceOf(addr1.address)
        //expect(apexBalance).to.be.equal(0)
        //expect(sapexBalance).to.be.equal(1000)
    });

});