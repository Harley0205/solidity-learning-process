// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
contract A {
    // Parent contracts can be called directly, or by using the keyword super
    // By usint the keyword super,all of the immediate parent contracts will be called.

    event Log(string message);
    
    function foo() public virtual {
        emit Log("A.foo called");
    }

    function bar() public virtual {
        emit Log("A.bar called");
    }

}

contract B is A {
    function foo() public virtual override {
        emit Log("B.foo called");
        A.foo();
    } 

    function bar() public virtual override {
        emit Log("B.bar called");
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    } 

    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
} 

/* D 是C和B的子合约 */
contract D is C,B {

    /*因为D是C和B的子合约，B合约在最后，所以super.foo()是调用的B合约的foo()函数，而不是C合约。这里要注意继承父合约的顺序 */
    /* override中合约顺序没关系，不影响super的调用，影响super的调用的是contract继承中的顺序。 */
    //只调用一个合约
    function foo() public override (C,B) {
        super.foo();
    }

    /* 因为B和C合约的bar() 方法都使用了super 关键字来调用，所以D合约的bar方法都先调用B，再调用C，最有调用A*/
    // 调用两个合约
    function bar() public override(B,C) { 
        super.bar();
    }

}