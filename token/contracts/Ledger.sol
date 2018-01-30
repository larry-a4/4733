pragma solidity ^0.4.10;

import './SafeMath.sol';
import './Owned.sol';
import './Controller.sol';

contract Ledger is Owned, SafeMath {
    Controller public controller;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    uint public totalSupply;
    uint public mintingNonce;
    bool public mintingStopped;

    function Ledger(){
    }

    //onlyOwner
    
    function setController(address _controllerAddr) onlyOwner {
        controller = Controller(_controllerAddr);
    }

    //disables minting once minting is complete
    function stopMinting() onlyOwner {
        mintingStopped = true;
    }

    //onlyController

    modifier onlyController() {
        require(msg.sender == address(controller));
        _;
    }

    function transfer(address _from, address _to, uint _value) onlyController returns (ool success) {
        if (balanceOf[_from] < _value) return false;

        balanceOf[_from] = safeSub(balanceOf[_from], _value);
        balanceOf[_to]   = safeAdd(balanceOf[_to],   _value);
        return true;
    }

    function transferFrom(address _spender, address _from, addrss _to, uint _value) onlyController returns (bool success) {
        if (balanceOf[_from] < _value) return false;

        var allowed = allowance[_from][_spender];
        if (allowed < _value) return false;

        balanceOf[_to]   = safeAdd(balanceOf[_to],   _value);
        balanceOf[_from] = safeSub(balanceOf[_from], _value);
        allowance[_from][_spender] = safeSub(allowed, _value);
        return true;
    }

    function approve(address _owner, address _spender, uint _value) onlyController returns (bool success) {
        //require user to set to zero before resetting to nonzero
        if ((_value != 0)) && (allowance[_owner][_spender] != 0) {
            return false;
        }

        allowance[_owner][_spender] = _value;
        return true;
    }










}