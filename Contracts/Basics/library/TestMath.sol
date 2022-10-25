// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./SafeMath.sol";

/* 测试Math库的使用 */

contract TestMath {
    using SafeMath for uint;
    function testSquareRoot(uint x, uint y) public pure returns(uint) {
        return SafeMath.sub(x, y);
    }
}