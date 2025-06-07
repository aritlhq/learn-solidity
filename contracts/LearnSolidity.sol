// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract HelloWorld {
    string sayHello = "Hello World!";

    function sayNow() public view returns (string memory){
        return (sayHello);
    }
}

contract BasicVarAndInt {
    int256 basic_price;
    int256 levels = 3;

    function getAll() public view returns (int256, int256) {
        return (basic_price, levels);
    }
}

contract SignedAndUnsignedInt {
    // int could be negative, like -3
    int256 a = -3;

    // uint could only be positive
    uint256 b = 10;

    // This will report errors
    // uint c = 3 - 5;

    int256 ourInteger = -10;
    uint256 outUInt = 10;

    function getAll()
        public
        view
        returns (
            int256,
            uint256,
            int256,
            uint256
        )
    {
        return (a, b, ourInteger, outUInt);
    }
}

contract IntegerWithBitSize {
    uint8 a;
    int256 b;
    int128 c;

    // uint127 d; This NOT valid because 127 is not a multiplier of 8.

    function getAll()
        public
        view
        returns (
            uint8,
            int256,
            int128
        )
    {
        return (a, b, c);
    }
}

contract BooleanLogic {
    bool a = true;
    bool b = false;

    // Negation
    bool c = !a;
    bool d = !c;

    // And
    bool e = d && a;
    bool f = e && b;
    bool g = e && true;

    // Or
    bool h = true || false;

    // Equality
    bool i = a == true;

    // Inequality
    bool k = a != true;

    function getAllBooleans()
        public
        view
        returns (
            bool,
            bool,
            bool,
            bool,
            bool,
            bool,
            bool,
            bool,
            bool,
            bool
        )
    {
        return (a, b, c, d, e, f, g, h, i, k);
    }
}

contract AddressArray {
    address address1 = 0x35701d003AF0e05D539c6c71bF9421728426b8A0;
    address address2 = address(0x123);

    function getAllAddresses() public view returns (address, address){
        return (address1, address2);
    }

    // address payable add = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    address add = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address b = add;
    // uint balance = b.balance;

    function getBalance() public view returns (uint){
        // return balance;
        return b.balance;
    }
}

contract AddressPayable {
    address payable add = payable(address(0x123));

    address payable add1 = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    address b = add1; // implicit converting from address payable to address
    address payable d = payable(b);

    function getBalance() public view returns (uint, uint, uint, uint){
        return (add.balance, add1.balance, b.balance, d.balance);
    }

    function getAddress() public view returns (address, address, address, address){
        return (add, add1, b, d);
    }

}

contract AddressPayable2 {
    address payable add = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    address b = add;

    uint balance = b.balance;

    function trans() public payable {
        add.transfer(10);
    }
}

contract Function{
    function add(int a, int b) public pure returns (int){
        return a + b;
    }   
}
