pragma solidity 0.8.20;

contract Gas {
    uint public index = 0;

    function forever() public {
        while(true){
            index += 1;
        }
    }
}