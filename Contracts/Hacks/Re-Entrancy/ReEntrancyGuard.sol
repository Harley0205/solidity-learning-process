// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/** 
 * 可以简单理解该合约就是一个类似于用户在银行存钱和取钱的合约。
 * 存钱之时会记录对应存钱的地址，与存入的金额
 * 取钱时会根据地址，然后取出对应地址的余额 (当然时正常情况下，此合约是有漏洞)
 */

contract Reentranct {
    mapping(address => uint) public balances;

    bool internal locked;

    modifier noReentrant() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public noReentrant {
        uint bal = balances[msg.sender];
        require(bal > 0,"Ether not enough");

        (bool succ, ) = msg.sender.call{value: bal}("");

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