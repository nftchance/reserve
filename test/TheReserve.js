const {
    time,
    loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Lock", function () {
    async function deployFactory() {
        // Contracts are deployed using the first signer/account by default
        const [owner, otherAccount] = await ethers.getSigners();

        const zeroAddress = "0x0000000000000000000000000000000000000000";

        const TheReserve = await ethers.getContractFactory("TheReserve");
        const theReserve = await TheReserve.deploy(
            owner.address,
            zeroAddress
        );
        await theReserve.deployed();

        return { theReserve, owner, otherAccount };
    }

    describe("Deployment", function () {
        it("Should set the right owner", async function () {
            const { theReserve, owner } = await loadFixture(deployFactory);

            expect(await theReserve.owner()).to.equal(owner.address);
        });

        it("Deploy test reserve", async function () {
            const { theReserve, owner } = await loadFixture(deployFactory);

            // run deployAReserve 
            await theReserve.connect(owner).deployAReserve("Test Reserve");
            await theReserve.connect(owner).deployAReserve("Test Reserve Second");

            // Listen for ReserveDeployed event
            let filter = theReserve.filters.ReserveDeployed();
            let events = await theReserve.queryFilter(filter);

            // Confirm the indexes of the 2 events are different
            expect(events[0].args.index).to.not.equal(events[1].args.index);
        });
    });
});
