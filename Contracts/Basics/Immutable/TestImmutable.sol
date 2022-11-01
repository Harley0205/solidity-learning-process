pragma solidity >=0.6.6;

/**
 *  immutable修饰的变量只能在构造器constructor中初始化，不能在普通的函数中修改或者赋值。
 *  而且immutable修饰的变量并不是存储在storage中，变量的值会被追加的运行时字节码中。（可以通过debug调试观察）
 *  因此immutable 比使用storage 状态变量gas便宜的多。
 * 唯一需要担心的时immutable修饰的变量的值无法更改。
 * immutable 使用场景：
 * 1. ERC20代币指定小数位置的decimals
 * 2. ERC20中保存创建者地址，关联合约地址等。
 */
contract TestImmutable {

    uint public immutable factory;
    uint public immutable WETH;

    constructor (uint _factory, uint _WETH) public{
        factory = _factory;
        WETH = _WETH;
    }

    // 报错
    /*TypeError: Immutable variables can only be initialized inline or assigned directly in the constructor.
        factory = _newFactory; */
    //function changeValues(uint _newFactory, uint _newWETH) public {
    //    factory = _newFactory;
    //    WETH = _newFactory;
    //}
}