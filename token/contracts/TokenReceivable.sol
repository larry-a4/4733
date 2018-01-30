pragma solidity ^0.4.10;

import './Owned.sol';
import './IToken.sol';

contract TokenReceivable is Owned {
    function claimTokens(address _token, address _to) onlyOwner returns (bool) {
        IToken token = IToken(_token);
        return token.transfer(_to, token.balanceOf(this));
    }
}