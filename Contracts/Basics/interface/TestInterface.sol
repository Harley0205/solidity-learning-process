// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface ICounter {
    function count() external view returns (uint);

    function increment() external;
}


contract Counter is ICounter{
    
    uint public _count;
    function count() external view returns (uint){
        return _count;
    }

    function increment() external {
        _count += 1;
    }
}


contract MyContract {
    
    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

    /* 使用create2方式生成合约，并调用合约的函数。 */
    function getAddress(address tokenA, address tokenB) external returns(address _addr) {
        bytes memory bytecode = type(Counter).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(tokenA,tokenB));

        assembly{
            _addr := create2(0,add(bytecode,0x20), mload(bytecode),salt)
        }

        /* 这里采用的是接口合约，然后传入实现接口的合约地址调用。*/
        //ICounter(_addr).increment();
        ICounter(_addr).count();
    }

    // count数加 1
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }

    // 查看 count 数
    function getCount(address _counter) external view returns (uint) {
        return ICounter(_counter).count();
    }
}