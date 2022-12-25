const networkConfig = {
  4: {
    name: "rinkeby",
    ethUsdPriceFeed: "Addr001",
  },
  137: {
    name: "polygon",
    ethUsdPriceFeed: "Addr002",
  },
  5: {
    name: "goerli",
    vrfCoordinatorV2: "0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D",
  },
}

const developmentChains = ["hardhat", "localhost"]
const DECIMALS = 8
const INITIAL_ANSWER = 200000000000

module.exports = {
  networkConfig,
  developmentChains,
  DECIMALS,
  INITIAL_ANSWER,
}
