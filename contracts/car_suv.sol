// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "./icar.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract CarSUV is ICar, ERC165 {
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

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override
        returns (bool)
    {
        return
            interfaceId == type(ICar).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}
