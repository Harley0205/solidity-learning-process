// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
 * 1. 先部署Counter1 和MyContract1 合约
 * 2. 再将Counter1合约地址传入 MyContract1合约的两个函数中，可执行查看结果。
 * 3. MyContract1合约，先后执行getCount(),incrementCounter(),getCount()，可发现值有增加，
 * 4. 查看Counter1 合约的值发现，count也有增加。
 * 原因 
 *     1: Counter1的count状态变量默认会生成一个count()函数，与接口对应。
 *     2: 接口与合约有相同的函数，方可这样调用，否则报错。
 *     3: 合约之间没有继承关系存在。
 */

interface ICounter1 {
    function count() external view returns (uint);

    function increment() external;
}


contract Counter1 {
    
    uint public count;

    function increment() external {
        count += 1;
    }
}


contract MyContract1 {
    
    // count数加 1
    function incrementCounter(address _counter) external {
        ICounter1(_counter).increment();
    }

    // 查看 count 数
    function getCount(address _counter) external view returns (uint) {
        return ICounter1(_counter).count();
    }
}