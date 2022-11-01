// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "./TestContract.sol";

contract FactoryAssembly {
    event Deployed(address addr, uint salt);

    // 1. 获取合约部署后的字节码
    // 注意: _owner and _foo 参数是合约构造函数传入的参数
    function getBytecode(uint _owner, uint _foo) public pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_owner, _foo));
    }

    // 2. 通过部署的合约计算合约对应的地址
    // 注意: _salt 是用来生成地址的随机数
    function getAddress(bytes memory bytecode, uint _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );

        // 注意: 地址的长度为20个字节，160位。
        return address(uint160(uint(hash)));
    }

    // 3. 部署合约
    // 注意:
    // log日志中的地址应该等于上面计算的地址。
    // 也就是说： deploy()函数和getAddress() 函数都可以部署合约并获得合约的地址。
    function deploy(bytes memory bytecode, uint _salt) public payable {
        address addr;

        /*
        注意: 如何使用create2 创建合约？
        create2(v, p, n, s) 
        v:第一个参数对应发送以太的数量，单位是wei
        p+n: 表示：使用内存中p到p+n的代码创建新合约。
        s: 
        */
        assembly {
            addr := create2(
                callvalue(), //v。 生成合约发送的以太，单位是wei
                // p。实际代码在跳过前32个字节后开始，0x20对应十进制就是32.
                add(bytecode, 0x20),
                mload(bytecode), // n。 loan代码的大小，其中包括实际代码的前32个字节。
                _salt //s。 函数参数
            )

            /* 判断生成的地址是否是合约地址 */
            /* 也可以用来判断合约地址和账户地址 */
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        emit Deployed(addr, _salt);
    }
}