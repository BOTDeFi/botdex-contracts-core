// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import '../BotdexERC20.sol';

contract ERC20 is BotdexERC20 {
    constructor(uint _totalSupply) {
        _mint(msg.sender, _totalSupply);
    }
}
