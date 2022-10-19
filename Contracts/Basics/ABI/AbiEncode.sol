// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract AbiEncode {

    struct Mystruct {
        string name;
        uint[2] nums;
    }

    function encode(uint x, address addr, uint[] calldata arr) external pure returns(bytes memory) {
        return abi.encode(x, addr, arr);
    }

    function decode(bytes calldata data) external pure returns(uint x, address addr, uint[] memory arr){
        (x, addr, arr) = abi.decode(data , (uint, address, uint[]));
    }

}