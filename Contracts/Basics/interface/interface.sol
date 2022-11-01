// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract testInterface {
    /** 可以通过声明一个接口与其他合约进行交互
     * 1. 不能有函数的功能 (只能定义函数，不能有其他功能)
     * 2. 可以继承其他接口
     * 3. 所有函数的声明必须是 external
     * 4. 不能定义构造器 constructor
     * 5. 不能定义状态变量
     */

     uint public count;
     function increment() external {
         count +=1;
     }
}

interface ICounter {
    function count() external view returns (uint);
    function increment () external ;
}

contract MyContract {
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }

    function getCount(address _counter) external view returns (uint) {
        return ICounter(_counter).count();
    }
}