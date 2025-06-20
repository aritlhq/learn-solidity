// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

// Unit 1 - Constant & Flow Control
contract ConstantExample {
    address public constant MY_ADDRESS =
        0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public constant MAXINPUT = 1;

    function input(uint256 num) public pure {
        require(num < MAXINPUT);
    }
}

contract ImmutableExample {
    address public immutable MY_ADDRESS;
    uint256 public immutable MY_UINT;

    constructor(address _myAddress, uint256 _myUint) {
        MY_ADDRESS = _myAddress;
        MY_UINT = _myUint;
    }
}

contract ContinueExample {
    uint256[] prices = [1, 2, 3, 4, 12];

    function countPrice() public view returns (uint256) {
        uint256 totalPrice = 0;

        for (uint256 i = 0; i < prices.length; i++) {
            if (prices[i] == 4) {
                continue;
            }

            totalPrice += prices[i];
        }

        return totalPrice;
    }
}

contract BreakExample {
    uint256[] prices = [1, 2, 13, 4, 200];

    function countPrice() public view returns (uint256) {
        uint256 totalPrice = 0;

        for (uint256 i = 2; i < prices.length; ) {
            if (prices[i] == 14) {
                continue;
            }

            if (totalPrice > 200) {
                break;
            }

            totalPrice += prices[i];
        }

        return totalPrice;
    }
}

// Unit 2 - Ether Transfer
contract FunctionPayableExample {
    function depositFunds() public payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
