// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/** msg.sender和tx.origin的区别
 * 如果合约A调用合约B，合约B调用合约C，合约C的msg.sender是合约B
 * 合约C的tx.origin是合约A。
 */
contract Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }


    function transfer(address payable _to, uint _amount) public {
        require(tx.origin == owner, "Not owner");

        /* 解决方法，就是换成下面的语句即可。 */
        //require(msg.sender == owner, "Not owner");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

}