// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    uint lastWaveAt;
    address lastWaver;

    constructor() {
        console.log("I'm a smart contract. Look at me being super smart!");
    }

    function wave() public {
        totalWaves += 1;
        lastWaveAt = block.number;
        lastWaver = msg.sender;

        console.log("Wave sent! The last person to wave was %s at block number %d.", lastWaver, lastWaveAt);
    }

    function getTotalWaves() public view returns (uint) {
        console.log("You've got %d total waves. Noice!!!", totalWaves);
        return totalWaves;
    }
}