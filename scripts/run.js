const main = async () => {

    const [owner, randomPerson] = await hre.ethers.getSigners();

    // Use the hardhat ethers plugin to create a contract object that includes
    // the contract abi. The name supplied needs to match the contract saved to
    // the contracts directory.
    // https://docs.ethers.io/v5/api/contract/contract-factory/#ContractFactory
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    
    // Deploys the contract and returns the address to which it will be deployed once mined
    // https://docs.ethers.io/v5/api/contract/contract-factory/#ContractFactory-deploy
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
    });
    
    // ethers Contract method that returns a promise with the contract
    // https://docs.ethers.io/v5/api/contract/contract/#Contract-deployed
    await waveContract.deployed();

    // Access the contract properties
    // https://docs.ethers.io/v5/api/contract/contract/#Contract--properties
    console.log("Contract deployed to: ", waveContract.address);
    console.log("Contract deployed by ", owner.address);

    // Test contract methods
    let waveCount;
    let waves;
    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log(`Contract Balance: ${hre.ethers.utils.formatEther(contractBalance)}`);
    waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave("this is a test message!");
    await waveTxn.wait();

    let waveTxn1 = await waveContract.wave("Wave #1!");
    await waveTxn1.wait();

    let waveTxn2 = await waveContract.wave("Wave #2!");
    await waveTxn2.wait();

    let waveTxn3 = await waveContract.wave("Wave #3!");
    await waveTxn3.wait();

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(`Contract Balance: ${hre.ethers.utils.formatEther(contractBalance)}`);

    let randomWaver = await waveContract.connect(randomPerson);
    let randomTxn = await randomWaver.wave("a random person says hi!");
    await randomTxn.wait();

    waveCount = await waveContract.getTotalWaves();
    waves = await waveContract.getWavesArray();
    console.log(waves);
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