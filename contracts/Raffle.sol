// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

error Raffle__NotEnoughETHEntered();

// Raffle
contract Raffle is VRFConsumerBaseV2 {
  uint256 private immutable i_entranceFee;
  address payable[] private s_players;

  event RaffleEnter(address indexed player);

  constructor(address vrfCoordinatorV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCoordinatorV2) {
    i_entranceFee = entranceFee;
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
  }

  function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
    //   console.log("")
  }

  function getPlayer(uint256 index) public view returns (address) {
    return s_players[index];
  }
}

// Enter the lottery paying some amount
// Pick a random winner
// Winner to be selected every XMinutes -> completely automated

// Chainlink Oracle -> Randomness, automated execution ( Chainlink Keeper )
