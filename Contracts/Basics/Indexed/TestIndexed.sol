// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/** indexed属性说明
 * 1. 在事件参数event上添加indexed属性，
 *    最多可以对三个参数增加这样的属性，增加了属性的变量，
 *    在web3.js中调用的时候可以进行值过滤。
 * 2. 没有设置indexed属性的值，在web3.js调用时会报错，报错信息如下
 *    cannot filter non-indexed parameters; must be null
 */

contract TestIndexed {
    event Deposit(
        address indexed from,
        bytes32 indexed id,
        uint value
    );

    function deposit(bytes32 id) public payable {

        emit Deposit(msg.sender, id, msg.value);
    }
}

// js 调用实例
//var abi = /* abi 由编译器产生 */;
//var ClientReceipt = web3.eth.contract(abi);
//var clientReceipt = ClientReceipt.at("0x1234...xlb67" /* 地址 */);

//var depositEvent = clientReceipt.Deposit();

// 监听变化
//depositEvent.watch(function(error, result) {
// 结果包含 非索引参数 以及 主题 topic
//    if (!error)
//        console.log(result);
//});

// 或者通过传入回调函数，立即开始听监
// var depositEvent = clientReceipt.Deposit(function(error, result) {
//    if (!error)
//        console.log(result);
//});
