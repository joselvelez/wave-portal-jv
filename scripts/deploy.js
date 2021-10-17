const main = async () => {
    // Get the first address in the getSigners() array and
    // assign it to the deployer variable
    const [deployer] = await hre.ethers.getSigners();
    const accountBalance = await deployer.getBalance();

    console.log("Deploying contract with account ", deployer.address);
    console.log("Account balance for deploying contract is ", accountBalance.toString());

    const portalContract = await hre.ethers.getContractFactory("WavePortal");
    const portal = await portalContract.deploy({
        value: hre.ethers.utils.parseEther('0.001'),
    });

    await portal.deployed();
    
    console.log("WavePortal has been deployed to the blockchain.");
    console.log("Contract address: ", portal.address);
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch(e) {
        console.error(e);
        process.exit(1);
    }
};

runMain();