pragma solidity ^0.8.13;

library SearchNum {
    function indexOf(
        uint[] storage self, 
        uint value
    ) public view returns (bool,uint)
    {
        for (uint i = 0; i < self.length; i++){
            if (self[i] == value){ 
                return (true, i);
            }
        }
        return (false, 0);
    }
}