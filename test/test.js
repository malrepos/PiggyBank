const { expect } = require("chai");
const { hexStripZeros } = require("ethers/lib/utils");
const  = require("hardhat/internal/hardhat-network/stack-traces/message-trace");

decribe("PiggyBank", () => {
  it("should do something", async () => {
    const PiggyBank = await hre.ethers.getContractFactory("PiggyBank");

    const contract = await PiggyBank.deploy();

    await contract.deployed();

    console.log("Contract address is: ", contract.address);

    expect(await contract.host.to.equal(msg.sender));
  });
});
