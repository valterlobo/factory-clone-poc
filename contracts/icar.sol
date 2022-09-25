// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

interface ICar {
    function getInfo()
        external
        view
        returns (
            address owner,
            string memory model,
            address carAddr,
            string memory carType
        );

    function setInfo(address owner, string memory model) external;
}
