// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "./icar.sol";

contract CarSUV is ICar {
    address public owner;
    string public model;
    address public carAddr;
    string constant typeCar = "CarSUV";

    constructor() {
        carAddr = address(this);
    }

    function getInfo()
        external
        view
        override
        returns (
            address,
            string memory,
            address,
            string memory
        )
    {
        return (owner, model, address(this), typeCar);
    }

    function setInfo(address _owner, string memory _model) external override {
        owner = _owner;
        model = _model;
    }
}
