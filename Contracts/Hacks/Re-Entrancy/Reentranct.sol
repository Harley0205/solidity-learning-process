// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/** 
 * 可以简单理解该合约就是一个类似于用户在银行存钱和取钱的合约。
 * 存钱之时会记录对应存钱的地址，与存入的金额
 * 取钱时会根据地址，然后取出对应地址的余额 (当然时正常情况下，此合约是有漏洞)
 */

contract Reentranct {
    mapping(address => uint) public balances;

    /* 转入Ether函数，转入后记录转入用户的地址和对应的金额 */
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    /* 取钱函数。balances中有对应地址的余额时 */
    /* 该地址的拥有者可以将Ether全部取出 */
    /* 取出后将balances对应地址的值赋值为0 */
    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0,"Ether not enough");

        /* 下面发送Ether调用call 没有发送msg.data */
        (bool succ, ) = msg.sender.call{value: bal}("");

        /* 下面发送Ether调用call 有发送msg.data */
        // (bool succ, ) = msg.sender.call{value: bal}("this is msg");

        require(succ, "Failed to send Ether");

        balances[msg.sender] = 0;
    }

    // 查看对应地址的余额
    function getBalAddr(address _addr) public view returns(uint256){
        return balances[_addr];
    }

    function getBal() public view returns(uint256) {
        return address(this).balance;
    }

}