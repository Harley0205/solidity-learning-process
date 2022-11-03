// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
 * library中不能声明任何状态变量, 也不能发送以太币。
 * 如果library中所有函数都是internal函数，那么库library将嵌入到合约中。如果库中有函数不是内部internal的话，库就需要先部署。
 */
library SafeMath {
    
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}