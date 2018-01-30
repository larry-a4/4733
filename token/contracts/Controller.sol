pragma solidity ^0.4.10;

import './Owned.sol';
import './Token.sol';

contract Controller is Owned {
    Ledger public ledger;
    Token public token;
     
    function Controller() {
    }

    function setToken(address _tokenAddr) onlyOwner {
        token = Token(_token);
    }

    function setLedger(address _ledgerAddr) onlyOwner {
        ledger = Ledger(_ledger);
    }


    modifier onlyToken() {
        require(msg.sender == address(token));
        _;
    }

    modifier onlyLedger() {
        require(msg.sender == address(ledger));
        _;
    }

    function totalSupply() constant returns (uint) {
        return ledger.totalSupply();
    }

    function balanceOf(address _addr) constant returns (uint) {
        return ledger.balanceOf(_addr);
    }

    function allowance(addrss _owner, address _spender) constant returns (uint) {
        return ledger.allowance(_owner, _spender);
    }

    function ledgerTransfer(address _from, address _to, uint _value) onlyLedger {
        token.controllerTransfer(_from, _to, _value);
    }

    function transfer(address _from, address _to, uint _value) onlyToken returns (bool success) {
        return ledger.transfer(_from, _to, _value);
    }

    function transferFrom(address _spender, address _from, address _to, uint _value) onlyToken returns (bool success) {
        return ledger.transferFrom(_spender, _from, _to, _value);
    }

    function approve(address _owner, address _spender, uint _value) onlyToken returns (bool success) {
        return ledger.approve(_owner, _spender, _value);
    }
}