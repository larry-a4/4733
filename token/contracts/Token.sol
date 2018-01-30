pragma solidity ^0.4.10;

import './SafeMath.sol';
import './Controller.sol';
import './EventDefinitions.sol';
import './TokenReceivable.sol';

contract Token is SafeMath, EventDefinitions, TokenReceivable {

    string constant public name = "LOVE";
    uint8 constant public decimals = 8;
    string constant public symbol = "LOVE";
    Controller public controller;

    //functions below this line are onlyOwner

    function setController(address _controllerAddr) onlyOwner {
        controller = Controller(_controllerAddr);
    }

    //functions below this line are public

    function balanceOf (address _addr) constant returns (uint) {
        return controller.balanceOf(_addr);
    }

    function totalSupply() constant returns (uint) {
        return controller.totalSupply();
    }

    function allowance(address _owner, address _spender) constant returns (uint) {
        return controller.allowance(_owner, _spender);
    }

    function transfer(address _to, uint _value) returns (bool success) {
        if (controller.transfer(msg.sender, _to, _value)) {
            Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }

    function transferFrom(address _from, address _to, uint _value) returns (bool success) {
        if (controller.transferFrom(msg.sender, _from, _to, _value)) {
            Tranfer(_from, _to, _value);
            return true;
        }
        return false;
    }

    function approve(address _spender, uint _value) returns (bool success) {
        if (controller.approve(msg.sender, _spender, _value)) {
            Approval(msg.sender, _spender, _value);
            return true;
        }
        return false;
    }



}