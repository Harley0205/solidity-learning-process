// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherGame {
    uint public targetAmount = 3 ether;
    /* 定义一个balance余额全局变量 */
    uint public balance;
    address public winner;

    /* 存入Ether：每次只能存入1 ether */
    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        /* 每次存入1 ether，balance 增加1，此处balance并不是部署合约中的balance */
        /* 所以即便被自毁函数攻击了，合约中balance会改变，但是不影响此处的balance变量 */
        balance += 1;
        /* 金额不到7 ether，游戏继续 */
        require(balance <= targetAmount, "Game is over");

        if(balance == targetAmount) {
            winner = msg.sender;
        }
    }


    function claimReward() public {
        require(msg.sender == winner, "Not winner");

        /* 此处转账balance是自定义的变量 */
        (bool succ, ) = msg.sender.call{value: balance}("");
        require(succ, "Failed to send Ether");
    }

} 