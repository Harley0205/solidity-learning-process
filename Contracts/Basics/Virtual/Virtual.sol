pragma solidity >=0.6.0;

/** virtual 修饰符总结. 0.6.0之后的版本中，虚函数必须要手动定义。
 *  1. 子合约继承父合约，并重写了父合约的函数，父合约的函数必须是 virtual 修饰
 *  2. 父合约函数如果没有virtual 修饰，子合约不能重写。但是子合约继承了父合约的方法，依然可以使用。如updateValue 函数
 *  3. 该例子中的父合约是正常合约，父合约如果是接口，或者抽象合约，情况也是一样的。
 */
contract AA {
    uint public x;

    // virtual 函数，CC合约必须重写它。否则报错
    function setValue(uint _x) public virtual {
        x = _x;
    }

    // 非virtual 函数，CC函数可以不重写，不会报错。
    function updateValue(uint _xx) public {
        x = _xx;
    }

    // virtual 函数，且在BB合约中没有该函数
    function addValue() public virtual {
        x= x + 1;
    }
}

contract BB {
    uint public y;
    function setValue(uint _y) public virtual {
        y = _y;
    }
}

contract CC is AA, BB {

    function setValue(uint _x) public override(BB,AA) {
        AA.x = _x;
        BB.y = _x;
    }

    // 因为这个函数只有AA有，BB没有，所以不需要指定继承的父合约
    function addValue() public override {
        x = x + 22;
    }

}