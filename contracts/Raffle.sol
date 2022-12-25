// SPDX-License-Identifier: MIT

error Raffle__NotEnoughETHEntered();

// Raffle
contract Raffle {
  uint256 private i_entranceFee;
  address payable[] private s_players;

  constructor(uint256 entranceFee) {
    i_entranceFee = entranceFee;
  }

  function getEntranceFee() public view returns (uint256) {
    return i_entranceFee;
  }

  function enterRaffle() public payable {
    if (msg.value < i_entranceFee) {
      revert Raffle__NotEnoughETHEntered();
    }
    s_players.push(payable(msg.sender));
  }

  function getPlayer(uint256 index) public view returns (address) {
    return s_players[index];
  }
}

// Enter the lottery paying some amount
// Pick a random winner
// Winner to be selected every XMinutes -> completely automated

// Chainlink Oracle -> Randomness, automated execution ( Chainlink Keeper )
