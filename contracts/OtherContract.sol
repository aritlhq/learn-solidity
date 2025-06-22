// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract OtherContract {
    uint256 public someVariable;

    constructor(uint256 _initialValue) {
        someVariable = _initialValue;
    }

    function someFunction() external view returns (uint256) {
        return someVariable;
    }
}
