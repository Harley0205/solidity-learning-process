// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Fallback {
    /** 以下任何一种情况都会执行
     * 1. 调用不存在的函数
     * 2. 直接给合约发送Ether, 但是没有receive()函数或者msg.data不为空
     *fallback has a 2300 gas limit when called by transfer or send.
     *
     * Question: msg.data是怎么发送和接收的 ？？？？？？？？？？？
     * (bool succ,) = _to.call{value:msg.value}("is fallback?");  此时最后的小括号里面的msg.data不为空，
     * 所以存在receive和fallback的情况下，调用的是fallback函数
     */

    event Log(uint gas);

    fallback() external payable {
        emit Log(gasleft());
    }

    receive() external payable {
        emit Log(123);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

contract sendToFallback {

    function transferToFallback(address payable _to) public payable {
        (bool succ,) = _to.call{value:msg.value}("is fallback?");
        require(succ,"Failed to send Ether");
    }
}