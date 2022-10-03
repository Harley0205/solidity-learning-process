// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherGame {
    uint public targetAmount = 3 ether;
    address public winner;

    /* 存入Ether：每次只能存入1 ether */
    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        uint balance = address(this).balance;
        /* 金额不到7 ether，游戏继续 */
        require(balance <= targetAmount, "Game is over");

        if(balance == targetAmount) {
            winner = msg.sender;
        }
    }


    function claimReward() public {
        require(msg.sender == winner, "Not winner");

        (bool succ, ) = msg.sender.call{value: address(this).balance}("");
        require(succ, "Failed to send Ether");
    }

} 