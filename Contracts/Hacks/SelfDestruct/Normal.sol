// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./EtherGame.sol";

contract Normal {
    EtherGame etherGame;

    constructor(EtherGame _etherGame) {
        etherGame = EtherGame(_etherGame);
    }

    function deposit() public payable{
        /* 向EtherGame 存入1 Ether */
        etherGame.deposit{value: 1 ether}();
    }

    /* 如果中奖，将中奖金额取出 */
    function withdraw() public payable{
        etherGame.claimReward();
    }

    fallback() external payable {}
    receive() external payable{}
}