pragma solidity 0.8.20;

contract UnitsInEthereum{
     uint public oneWei = 1 wei;
     bool public inOnewei = 1 wei == 1;
     
     uint public oneEther = 1 ether; 
     bool public isOneEther = 1 ether == 1e18; //10**18
     bool public isOneEtherV2 = 1 ether == 10**18;
}