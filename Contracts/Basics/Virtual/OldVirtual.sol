pragma solidity < 0.6.0;

/** 合约说明
 * 1. 合约A，合约B都有相同的函数setValue，分别进行不同操作
 * 2. 合约C，继承了A和B合约，因为B合约继承在后
 * 3. 部署C合约后，发现C合约中有两个函数，一个setValue(), 一个是setValue(uint _y)；还有两个变量x和y。
 * 如果C合约没有重写setValue()
 *  4. 点击函数setValue(),发现改了y的值，但是x值不变
 *  5. 点击函数setValue(uint _y), 并传入一个新的值，y的值便将为新的输入的值。
 * 如果C合约重写了setValue()函数，那么就是执行重写的函数。
 */

contract A {
    uint public x;
    function setValue() public {
        x = 1;
    }
}

contract B {
    uint public y;
    function setValue() public {
        y = 2;
    }
}

contract C is A, B {
    
    // 这个是新函数
    function setValue(uint _y) public {
        y = _y;
    }

    // 重写的函数, 在0.5版本中，函数都是隐式虚函数(virtual),可以直接重写也不需要override
    function setValue() public{
        x = 11;
        y = 22;
    }
}
 