const ZERO_ADDRESS = "0x0000000000000000000000000000000000000000";

async function main() {
    // We get the contract to deploy
    const Greeter = await ethers.getContractFactory("BotdexFactory");
    const greeter = await Greeter.deploy(ZERO_ADDRESS);
  
    console.log("BotdexFactory deployed to:", greeter.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });