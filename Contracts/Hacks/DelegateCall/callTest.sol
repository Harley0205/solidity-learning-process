// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Receiver {

    event Received(address caller, uint amount, string message);
    
    fallback() external payable {
        emit Received(msg.sender,msg.value,"Fallback was called");
    }

    function foo(string memory _message, uint _x) public payable returns(uint) {
        emit Received(msg.sender, msg.value, _message);
        return _x + 1 ;
    }
}

contract Caller {
    event Response(bool succ, bytes data);

    /* call有发送以太的操作，所以需要payable修饰符 */
    /* call 调用foo函数后，foo函数中msg.sender为receiver合约的地址，而不是caller合约的地址 */
    function testCallFoo(address payable _addr) public payable {
        (bool succ, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("foo(string,uint256)","call foo",123)
        );
        emit Response(succ, data);
    }

    /* delegatecall 不能发送以太给指定地址，并且delegatecall 调用的时候是在本合约中执行的*/
    /* 调用 foo 函数中msg.sender为本合约caller地址 而不是receiver地址 */
    function testdelegateCallFoo(address payable _addr) public payable {
        (bool succ, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSignature("foo(string,uint256)","call foo",123)
        );
        emit Response(succ, data);
    }

    /* call 只是调用函数，并没有发送以太，所以不需要payable */
    /* 如果call调用的地址对应没有该函数，则调用对应地址的fallback函数 */
    function testCallDoesNotExistFunc(address _addr) public {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        emit Response(success,data);
    }
}