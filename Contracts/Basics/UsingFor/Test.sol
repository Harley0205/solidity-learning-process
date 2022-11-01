pragma solidity ^0.8.13;
import "./SearchNum.sol";

/** using for 指令
 *  using A for B： 用库A 关联到 类型B，
 *  然后类型B的变量就可以调用 库A中的函数。
 */
contract Test {
    using SearchNum for uint[];
    uint[] data;

    // 向uint数组中添加值
    function addNum(uint value) public {
        data.push(value);
    }

    // 替换数组中的值
    function replaceNum(uint _oldNum, uint _newNum) public {
        // 这里使用的是library SearchNum 的查找
        (bool succ, uint index) = data.indexOf(_oldNum);
        require(succ, "oldNum is not exists");
        data[index] = _newNum;
    }

    // 查找索引的值
    function getValue(uint _index) public view returns(uint) {
        return data[_index];
    }
}
