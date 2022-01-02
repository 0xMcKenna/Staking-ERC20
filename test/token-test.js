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
        const apexAmount = 1000;
        await apex.transferFrom(owner, addr1, apexAmount)

        const apexBalance1 = await apex.balanceOf(owner);

        await sapex.connect(addr1).stake(1000, {from: addr1});

        const apexBalance2 = await apex.balanceOf(owner);
        const sapexAmount = await sapex.balanceOf(addr1)

        expect(apexBalance2).to.be.equal(0)
        expect(sapexAmount).to.be.equal(1000)
    });

});