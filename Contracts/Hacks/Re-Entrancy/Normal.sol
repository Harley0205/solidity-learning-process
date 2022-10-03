// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Reentranct.sol";

contract Normal {
    Reentranct public reentranct;

    constructor(address _reentranct) {
        reentranct = Reentranct(_reentranct);
    }

    fallback() external payable {}
    receive() external payable {}

    function deposit() public payable {
        require(msg.value >= 1 ether, "msg.value is 0");
        // 调用存钱函数，只存入1 Ether，如果msg.value > 1 ether,剩下的会存入合约当中。
        reentranct.deposit{value: 1 ether}();
    }

    function withdraw() public payable {
        reentranct.withdraw();
    }

    /* 查看当前合约账户余额 */
    function getBal() public view returns(uint256) {
        return address(this).balance;
    }

}