// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "./icar.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract CarImpl is ICar, ERC165 {
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
