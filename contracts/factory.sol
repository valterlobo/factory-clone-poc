// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "./icar.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/utils/Address.sol";

import {ERC165Checker} from "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";

contract CarFactory {
    using Address for address;
    ICar[] public cars;
    mapping(string => address) private contractsTypeCar;

    using Address for address;

    function addType(string memory _type, address _contract) public {
        require(_contract.isContract(), "Car address must be a contract");
        bool checkIsICar = ERC165Checker.supportsInterface(_contract, type(ICar).interfaceId);
        require(checkIsICar, "Car address must be the same type ICar");

        /*
        console.log(
            ERC165Checker.supportsInterface(_contract, type(ICar).interfaceId)
        );*/
        contractsTypeCar[_type] = _contract;
    }

    function createCar(
        string memory _type,
        address _owner,
        string memory _model
    ) public {
        address carAddr = contractsTypeCar[_type];
        console.log(carAddr);
        //require(carAddr.isContract(), "Car addr. must be a contract");

        address carTypeAddr = Clones.clone(carAddr);
        ICar(carTypeAddr).setInfo(_owner, _model);
        cars.push(ICar(carTypeAddr));
    }

    function getCar(uint256 _index)
        public
        view
        returns (
            address,
            string memory,
            address,
            string memory
        )
    {
        ICar car = cars[_index];

        return car.getInfo();
    }
}
