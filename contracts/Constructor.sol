pragma solidity 0.8.20;

contract ParentContract {
    uint public myNumberParent;

    constructor(uint _myNumber){
        myNumberParent = _myNumber;
    }

}

contract Constructor is ParentContract{

    uint public myNumber;

    constructor(uint _myNumber) ParentContract(1){
        myNumber = _myNumber;
    }
}