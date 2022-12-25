// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

error Raffle__NotEnoughETHEntered();

// Raffle
contract Raffle is VRFConsumerBaseV2 {
  uint256 private immutable i_entranceFee;
  address payable[] private s_players;
  VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
  bytes32 private immutable i_gasLane;
  uint64 private immutable i_subscriptionId;
  uint32 private immutable i_callbackGasLimit;
  uint16 private constant REQUEST_CONFIRMATIONS = 3;
  uint32 private constant NUM_WORDS = 1;

  event RaffleEnter(address indexed player);
  event RequestedRaffleWinner(uint256 indexed requestId);

  constructor(
    address vrfCoordinatorV2,
    uint256 entranceFee,
    bytes32 gasLane,
    uint64 subscriptionId,
    uint32 callbackGasLimit
  ) VRFConsumerBaseV2(vrfCoordinatorV2) {
    i_entranceFee = entranceFee;
    i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
    i_gasLane = gasLane;
    i_subscriptionId = subscriptionId;
    i_callbackGasLimit = callbackGasLimit;
  }

  function getEntranceFee() public view returns (uint256) {
    return i_entranceFee;
  }

  function enterRaffle() public payable {
    if (msg.value < i_entranceFee) {
      revert Raffle__NotEnoughETHEntered();
      // return true;
    }
    s_players.push(payable(msg.sender));
    emit RaffleEnter(msg.sender);
  }

  function requestRandomWinner() external {
    // Request a random number
    // Once we get it, do something with it
    // 2 transaction process
    uint256 requestId = i_vrfCoordinator.requestRandomWords(
      i_gasLane,
      i_subscriptionId,
      REQUEST_CONFIRMATIONS,
      i_callbackGasLimit,
      NUM_WORDS
    );
    emit RequestedRaffleWinner(requestId);
  }

  function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
    uint256 indexOfWinner = ranoomWords[0] % s_players.length;
    address payable recentWinner = s_players[indexOfWinner];
  }

  function getPlayer(uint256 index) public view returns (address) {
    return s_players[index];
  }
}

// Enter the lottery paying some amount
// Pick a random winner
// Winner to be selected every XMinutes -> completely automated

// Chainlink Oracle -> Randomness, automated execution ( Chainlink Keeper )
