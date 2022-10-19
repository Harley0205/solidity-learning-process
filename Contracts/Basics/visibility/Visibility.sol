// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract visibility {
    // 可见性
    /** 函数被定义为：
     * public   : 表示 任何合约和账户都能调用
     * private  : 表示 只能在定义函数的合约内部调用
     * internal : 表示 只能在继承了函数的合约内部调用
     * external : 表示 只有其他合约和账号能调用，内部无法调用
     */

    /* private function */
    /* 本合约内部可以调用，继承该合约的合约内部不能调用*/
    function privateFunc() private pure returns(string memory) {
         return "private function called";
     }

     function testPrivateFunc() public pure returns(string memory) {
         return privateFunc();
     }

    /* internal function */
    /* 当前合约与继承的合约的内部可以调用 */
    function internalFunc() pure internal returns(string memory) {
        return "internal function called";
    }

    function testInternalFunc() public pure virtual returns (string memory) {
        return internalFunc();
    }

    /* public function */
    function publicFunc() public pure returns(string memory) {
        return "public function called";
    }

    /* external function */
    function externalFunc() external pure returns(string memory) {
        return "external function called";
    }

    function testExternalFunc() public pure returns(string memory){
        // returns externalFunc();  // 报错
        return "external function can only be called by other contracts and accounts" ;
    }

    /* state variables 状态变量 */
    string public publicVar = "my public variable";
    string private privateVar = "my private variable";
    string internal internalVar = "my internal variable";
    
    //状态变量不支持关键字 external 修饰
    //string external externalVar = "my external variable";
}

contract Child is visibility {

    function test() public pure returns(string memory) {
        /* 能调用 */
        //return internalFunc();
        return publicFunc();

        /* 不能调用 */
        // return privateFunc();
        // return externalFunc();
    }   
}