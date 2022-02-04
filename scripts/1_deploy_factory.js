const ZERO_ADDRESS = "0x0000000000000000000000000000000000000000";

async function main() {
    // We get the contract to deploy
    const Factory = await ethers.getContractFactory("BotdexFactory");
    const factory = await Factory.deploy(ZERO_ADDRESS);
  
    console.log("BotdexFactory deployed to:", factory.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });