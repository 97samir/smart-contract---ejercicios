pragma solidity 0.8.20;

import "./EnumStatus.sol";
contract Enum {

    Status public status;

    function get() public view returns(Status){
        return status;
    }

    function set(Status _status) public{
        status = _status;
    }

    function cancel() public{
        status = Status.CANCELED;
    }

    function reset() public{
        delete status;
    }
}