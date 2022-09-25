const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Car Factory", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployContract() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const CarFactory = await ethers.getContractFactory("CarFactory");
    const carFactory = await CarFactory.deploy();

    const CarImpl = await ethers.getContractFactory("CarImpl");
    const carImpl = await CarImpl.deploy();


    const CarSUV = await ethers.getContractFactory("CarSUV");
    const carSUV = await CarSUV.deploy();

    return { carFactory, carImpl, carSUV, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should deploy car ", async function () {
      const { carFactory, carImpl, carSUV, owner, otherAccount } =
        await loadFixture(deployContract);

      await carFactory.addType("basic", carImpl.address)
      console.log("basic", carImpl.address)
      await carFactory.addType("suv", carSUV.address)
      console.log("suv", carSUV.address)

      await carFactory.createCar("suv", owner.address, "RENEGADE")
      await carFactory.createCar("suv", otherAccount.address, "RENEGADE")
      await carFactory.createCar("basic", owner.address, "CELTA")

      let infoSuv = await carFactory.getCar(0)
      console.log(infoSuv)
      let infoSuv2 = await carFactory.getCar(1)
      console.log(infoSuv2)
      let infoBasic = await carFactory.getCar(2)
      console.log(infoBasic)

      const jsonAbi = `[
        {
          "inputs": [],
          "name": "getInfo",
          "outputs": [
            {
              "internalType": "address",
              "name": "owner",
              "type": "address"
            },
            {
              "internalType": "string",
              "name": "model",
              "type": "string"
            },
            {
              "internalType": "address",
              "name": "carAddr",
              "type": "address"
            },
            {
              "internalType": "string",
              "name": "carType",
              "type": "string"
            }
          ],
          "stateMutability": "view",
          "type": "function"
        },
        {
          "inputs": [
            {
              "internalType": "address",
              "name": "owner",
              "type": "address"
            },
            {
              "internalType": "string",
              "name": "model",
              "type": "string"
            }
          ],
          "name": "setInfo",
          "outputs": [],
          "stateMutability": "nonpayable",
          "type": "function"
        }
      ]`;

      const carTemplate = new ethers.Contract(
        infoBasic[2],
        jsonAbi,
        owner);


      // await  car2.attach

      // const carBasic = await carTemplate.attach(infoBasic[2])

      await carTemplate.setInfo(otherAccount.address, "CELTAXOP")
      console.log("XXXXXXXXXXXXXXXXXXXXXXXXXX")
      let infoBasicx = await carFactory.getCar(2)
      console.log(infoBasicx)
    });

  });
});

