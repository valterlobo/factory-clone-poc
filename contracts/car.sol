// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "./icar.sol";

contract CarImpl is ICar {
    address public owner;
    string public model;
    address public carAddr;

    constructor() {}

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
        return (owner, model, address(this), "BASIC");
    }

    function setInfo(address _owner, string memory _model) external override {
        owner = _owner;
        model = _model;
    }
}
