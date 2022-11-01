// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TestContract {
    uint public balance;
    uint public foo;

    /* 构造器 */
    constructor(uint _balance, uint _foo) payable {
        balance = _balance;
        foo = _foo;
    }

    /* 测试函数 */
    function getBalance(uint val) public view returns (uint) {
        return balance + val;
    }
}