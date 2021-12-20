pragma solidity >=0.8.0;

import './interfaces/IBotdexFactory.sol';
import './BotdexPair.sol';

contract BotdexFactory is IBotdexFactory {
    bytes32 public constant INIT_CODE_PAIR_HASH = keccak256(abi.encodePacked(type(BotdexPair).creationCode));

    address public override feeTo;
    address public override feeToSetter;

    mapping(address => mapping(address => address)) public override getPair;
    address[] public override allPairs;

    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view override returns (uint) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external override returns (address pair) {
        require(tokenA != tokenB, 'Botdex: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'Botdex: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'Botdex: PAIR_EXISTS'); // single check is sufficient
        pair = address(new BotdexPair{salt: keccak256(abi.encodePacked(token0, token1))}());
        IBotdexPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external override {
        require(msg.sender == feeToSetter, 'Botdex: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external override {
        require(feeToSetter == msg.sender, 'Botdex: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }
}
