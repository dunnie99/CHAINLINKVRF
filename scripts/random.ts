import { ethers } from "hardhat";

async function main() {
    const [owner] = await ethers.getSigners();
  
    const rangen = await ethers.getContractFactory("randomGenarator");
    const randGen = await rangen.deploy();
    await randGen.deployed();

    console.log(`randomGenerator contract is ${randGen.address}`);


    


}






// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});






















