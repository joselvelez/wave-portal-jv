const main = async () => {
    // Use the hardhat ethers plugin to create a contract object that includes
    // the contract abi. The name supplied needs to match the contract saved to
    // the contracts directory.
    // https://docs.ethers.io/v5/api/contract/contract-factory/#ContractFactory
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    
    // Deploys the contract and returns the address to which it will be deployed once mined
    // https://docs.ethers.io/v5/api/contract/contract-factory/#ContractFactory-deploy
    const waveContract = await waveContractFactory.deploy();
    
    // ethers Contract method that returns a promise with the contract
    // https://docs.ethers.io/v5/api/contract/contract/#Contract-deployed
    await waveContract.deployed();

    // Access the contract properties
    // https://docs.ethers.io/v5/api/contract/contract/#Contract--properties
    console.log("Contract deployed to: ", waveContract.address);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch(e) {
        console.log(e);
        process.exit(1);
    }
};

runMain();