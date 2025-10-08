pragma solidity 0.8.20;

contract Loops {

    uint public variableOne;
    uint public variableTwo;
    uint public variableThree;
    uint public variableFour;

    function ourLoop() public {
        for(uint i = 0; i < 20; i++){
            if(i == 10){
                variableOne = i;
                continue;
            }

            if(i == 15){
                variableTwo = i;
                break;
            }

            variableThree = i;
        }

        uint h;
        while(h < 10){
            h++;
        }

        variableFour = h;
    }
}