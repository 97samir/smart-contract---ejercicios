pragma solidity 0.8.20;

contract Events {

    event Transfer(uint indexed amount, address indexed to, address indexed from);
    bytes32 public mySelector;

    function transfer(uint _amount, address _to) external {
        mySelector = Transfer.selector;
        emit Transfer(_amount, _to, msg.sender);
    }
    
}