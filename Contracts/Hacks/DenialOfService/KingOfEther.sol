// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
 
contract KingOfEther {
    address public king;
    uint public balance;

    fallback() external payable{}
    receive() external payable{}

    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more to become the king");

         /* 返还balance余额给前国王 ​*/
        (bool sent, ) = king.call{value: balance}("");
        require(sent, "Failed to send Ether");

        /* 国王king信息更新 */
        balance = msg.value;
        king = msg.sender;
    }
}