pragma solidity 0.8.20;

contract Errors {

    function testRequire(uint _x) public pure {
        require(_x > 10, "Must be greater than 10");
    }

    function testRevert(uint _x) public pure {
        if(_x <=10){
            revert("Must be greater than 10");
        }
    }

    uint public myNumber = 100;

    function testAssert() public view{
        assert(myNumber == 100);
    }

    error InsufficientBalance(uint amount, address user);
    error CustomError(string);

    uint public userBalance = 100;

    function withdraw(uint _amountToWithdraw) public view {
        if(_amountToWithdraw <= userBalance){
            revert InsufficientBalance(_amountToWithdraw, msg.sender);
        }else{
            revert CustomError("Insufficient balance");
        }
    }
}