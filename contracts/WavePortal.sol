// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint private _totalWaves;
    uint private _lastWaveAt;
    address private _lastWaver;
    uint private _maxWaves;
    address private _topWaver;
    mapping(address => uint) private _lastWaveTimestamp;
    mapping(address => uint) private _waves;

    constructor() {
        console.log("I'm a smart contract. Look at me being super smart!");
    }

    function wave() public {
        _totalWaves += 1;
        _lastWaveAt = block.timestamp;
        _lastWaver = msg.sender;

        console.log("Wave sent! The last person to wave was %s at block number %d.", _lastWaver, _lastWaveAt);
    }

    function getTotalWaves() public view returns (uint) {
        console.log("You've got %d total waves. Noice!!!", _totalWaves);
        return _totalWaves;
    }

    function getLastWaveAt() public view returns (uint) {
        console.log("The last wave was ", _lastWaveAt);
        return _lastWaveAt;
    }

    function getLastWaver() public view returns (address) {
        console.log("The last waver was ", _lastWaver);
        return _lastWaver;
    }

    function getMaxWaves() public view returns (uint) {
        console.log("The most waves is currently", _maxWaves);
        return _maxWaves;
    }

    function getTopWaver() public view returns (address) {
        console.log("The highest waver is currently ", _topWaver);
        return _topWaver;
    }

    function getWaverLast() public view returns (uint) {
        console.log("You last waved at ", _lastWaveTimestamp[msg.sender]);
        return _lastWaveTimestamp[msg.sender];
    }

    function getWaverWaves() public view returns (uint) {
        console.log("Your total waves are ", _waves[msg.sender]);
        return _waves[msg.sender];
    }
}
