// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint private _seed;
    uint private _totalWaves;
    uint private _lastWaveAt;
    address private _lastWaver;
    uint private _maxWaves;
    address private _topWaver;
    mapping(address => uint) private _senderWaves;
    mapping(address => uint) private _lastSenderWave;
    
    event NewWave(address indexed from, uint timestamp, string message);
    
    struct Wave {
        address waver;
        string message;
        uint timestamp;
    }

    Wave[] private _wavesArray;

    uint private _prizeAmount = 0.0001 ether;

    constructor() payable {
        console.log("I'm a smart contract. Look at me being super smart!");
        /*
            Set the initial seed
        */
        console.log("Initializing the seed...");
        _seed = (block.timestamp + block.difficulty) % 100;
        console.log("Initial seed set to ", _seed);
    }

    function wave(string memory _message) public {

        /*
            Require user to wait at least 15 minutes for sending another wave
        */
        require(
            _lastSenderWave[msg.sender] + 30 seconds < block.timestamp,
            "Chill spammer, you need to wait at least 30 seconds!"
        );

        /*
            Update last time user sent a wave
        */
        _lastSenderWave[msg.sender] = block.timestamp;

        _totalWaves += 1;
        _lastWaveAt = block.timestamp;
        _lastWaver = msg.sender;
        _senderWaves[msg.sender] += 1;

        /*
            Set chance of user winning to 50%
        */
        if (_seed <= 50) {
            console.log("%s has won a nice little prize!", msg.sender);

            require(_prizeAmount <= address(this).balance,
            "You are trying to withdraw more than this account has!"
        );

        (bool success, ) = (msg.sender).call{value: _prizeAmount}("");
        require(success, "Failed to withdraw from contract");
        }

        if (_senderWaves[msg.sender] >= _maxWaves) {
            _topWaver = msg.sender;
            _maxWaves = _senderWaves[msg.sender];
        }

        _wavesArray.push(Wave(msg.sender, _message, block.timestamp));

        /*
            Generate a psuedo random number between 0 and 100
        */
        _seed = (block.difficulty + block.timestamp) % 100;
        console.log("Generating seed... seed set to %s", _seed);

        emit NewWave(msg.sender, block.timestamp, _message);

        console.log("Wave sent! The last person to wave was %s at block number %d with seed %s", _lastWaver, _lastWaveAt, _seed);
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

    function getSenderWaves() public view returns (uint) {
        console.log("Your total waves are ", _senderWaves[msg.sender]);
        return _senderWaves[msg.sender];
    }

    function getWavesArray() public view returns (Wave[] memory) {
        return _wavesArray;
    }
}
