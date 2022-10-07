// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
 * 应对拒绝服务攻击的方法也很简单
 * 只要将判断king的逻辑和ether转账交易的逻辑分隔开就行
 * 提示：智能合约中的业务逻辑与转账逻辑最好分开写
 * 业务逻辑交由合约判定，转账交易交给符合条件的address自己控制
 */
contract KingOfEther {
    address public king;
    uint public balance;
    mapping(address => uint) public balances;

    /* king判断逻辑 */
    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more to become the king");

        balances[king] += balance;

        balance = msg.value;
        king = msg.sender;
    }

    /* 前king取出ether逻辑，并且当前king无法取出ether */
    function withdraw() public {
        require(msg.sender != king, "Current king cannot withdraw");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}