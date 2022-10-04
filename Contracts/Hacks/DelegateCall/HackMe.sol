// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./Lib.sol";

contract HackMe {
    address public lib;
    address public owner;
    uint public someNumber;

    constructor(address _lib) {
        lib = _lib;
    }

   function doSomething(uint _num) public {
       lib.delegatecall(abi.encodeWithSignature("doSomething(uint256)",_num));
   }

}