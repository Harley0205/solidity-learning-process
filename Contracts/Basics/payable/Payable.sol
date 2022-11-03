// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Payable {

    // payable地址可以接收 Ether 
    address payable public owner;

    // payable 构造器可以接收 Ether
    constructor () payable {
        owner = payable(msg.sender);
    }

    // 将以太存入本合约
    // 与一些Ether一起调用此函数
    // 当前合约的余额会自动更新
    function deposit() public payable {}

    // 用Ether一起调用会报错
    function notPayable() public {}

    function withdraw() public {
        uint amount = address(this).balance;

        (bool succ, ) = owner.call{value:amount}("");
        require(succ, "Failed to send Ether");
    }

    // 请注意： _to地址被定义为 payable
    function transfer(address payable _to, uint _amount) public {
        (bool succ, ) = _to.call{value:_amount}("");
        require(succ, "Failed to send Ether");
    }


}