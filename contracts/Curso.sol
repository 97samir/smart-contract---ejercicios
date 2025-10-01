pragma solidity 0.8.20;

contract Curso {

    //Boolean
    bool public isValid = true;
    bool public isInvalid;

    // Integer si signo
    uint8 private u8 = 10;
    uint256 private u256 = 500;
    uint public u250 = 300;
    uint public initial;

    // Integers
    int8 public i8 = type(int8).max;
    int256 public i256 = -1;
    int public i300 = -2;
    int public initialInteger = type(int256).max;

    //address public myAdress = address(0);

    // Address
    address public myAdress = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    address public initialAddress;
    
}