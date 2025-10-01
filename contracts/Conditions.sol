pragma solidity 0.8.20;

contract Conditions {

    function foo(uint _number) public pure returns (uint){
        if(_number < 100){
            return 0;
        }else if(_number > 200){
            return 1;
        }else{
            return 2;
        }
    }

    function ternary(uint _number) public pure returns(uint){
        return (_number < 10) ? 1 : 2; 
    }
}