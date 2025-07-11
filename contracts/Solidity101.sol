// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ValueAndReferenceTypeExample {
    string sayHello = "Hello World!";

    function sayNow() public view returns (string memory) {
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

    function getAllAddresses() public view returns (address, address) {
        return (address1, address2);
    }

    // address payable add = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    address add = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address b = add;

    // uint balance = b.balance;

    function getBalance() public view returns (uint256) {
        // return balance;
        return b.balance;
    }
}

contract AddressPayable {
    address payable add = payable(address(0x123));

    address payable add1 = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    address b = add1; // implicit converting from address payable to address
    address payable d = payable(b);

    function getBalance()
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256
        )
    {
        return (add.balance, add1.balance, b.balance, d.balance);
    }

    function getAddress()
        public
        view
        returns (
            address,
            address,
            address,
            address
        )
    {
        return (add, add1, b, d);
    }
}

contract AddressPayable2 {
    address payable add = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    address b = add;

    uint256 balance = b.balance;

    function trans() public payable {
        add.transfer(10);
    }
}

contract Function {
    function add(int256 a, int256 b) public pure returns (int256) {
        return a + b;
    }
}

contract FunctionInput {
    function add(
        int256 a,
        int256 b,
        bool c,
        address d
    )
        public
        pure
        returns (
            int256,
            bool,
            address
        )
    {
        return (a + b, c, d);
    }
}

contract FunctionOutput {
    function add(int256 a, int256 b) public pure returns (int256) {
        return a + b;
    }
}

contract FunctionAlternativeOutput {
    function sum() public pure returns (int256 k, int256 j) {
        k = 10;
        j = 15;
    }
}

contract FunctionCall {
    // Function to add two integers
    function add(int256 a, int256 b) public pure returns (int256) {
        return a + b;
    }

    // Function to add three integers
    function addUp(
        int256 a,
        int256 b,
        int256 c
    ) public pure returns (int256) {
        int256 d = add(a, b);
        return add(d, c);
    }

    // Function to add and multiply two integers
    function addMul(int256 a, int256 b) public pure returns (int256, int256) {
        return (a + b, a * b);
    }

    // Function to add and multiply three integers
    function addMulUp(
        int256 a,
        int256 b,
        int256 c
    ) public pure returns (int256, int256) {
        (int256 d, int256 e) = addMul(a, b);
        return addMul(d, c + e);
    }

    function subtract(int256 j, int256 i) public pure returns (int256) {
        return j - i;
    }

    function example(int256 j, int256 i) public pure returns (int256 result) {
        result = subtract(j, i);
    }
}

contract ScopePublicAndPrivate {
    uint256 public a;

    function aa() public {
        a++;
    }

    uint256 private b;

    function bb() private {
        b++;
    }
}

contract ScopeInternal {
    uint256 public result;

    function aa(uint256 a) internal {
        result = a + 1;
    }

    function b(uint256 b_) public {
        aa(b_);
    }
}

contract ScopeExternal {
    uint256 public result;

    function aa(uint256 a) external {
        result = a + 1;
    }

    function b(uint256 b_) public {
        this.aa(b_);
    }
}

contract MappingDefinition {
    // Create a mapping that has a key of type address and a value of type uint named owned_book;
    mapping(address => uint256) private owned_book;

    function add_book(uint256 bookId) public {
        owned_book[address(0x123)] = bookId;
    }

    function getBook(address addr) public view returns (uint256) {
        return owned_book[addr];
    }
}

contract MappingAddAndUpdate {
    mapping(uint256 => bool) public myMapping;

    function set() public {
        myMapping[50] = true;
    }

    // If you call 50, the result is true.
}

contract MappingQuery {
    mapping(address => uint256) private owned_book;

    function add_book(address owner, uint256 bookId) public {
        owned_book[owner] = bookId;
    }

    function get_book(address owner) public view returns (uint256) {
        return owned_book[owner];
    }
}

contract MappingQuery2 {
    mapping(int256 => bool) public flags;

    constructor() {
        flags[42] = true;
    }

    function myFunction() public view returns (bool) {
        bool checkFlags = flags[42];
        return checkFlags;
    }
}

contract MappingDelete {
    mapping(address => uint256) public balance;

    function add() public {
        balance[address(0x123)] = 10;
    }

    function deleteF() public {
        delete balance[address(0x123)];
    }

    function update() public {
        balance[address(0x123)] += 60;
    }
}

contract StateVariable {
    int256 bookID; // State variable
    bool read; // State variable

    function a() public returns (int256) {
        bookID = 3;

        int256 bookId = bookID;
        return bookId;
    }

    function b() public returns (int256) {
        return a();
    }
}

contract LocalVariable {
    uint256 c;

    function getResult() public returns (uint256) {
        uint256 a = 1; // Local variable
        uint256 b = 2; // Loval variable
        uint256 result = a + b; // Loval variable
        c = result; // This is not a local variable

        return result; // Access the local variable
    }
}

contract StateMutabilityPure {
    mapping(int256 => int256) aa;

    // This is pure function (state mutability)
    function add(int256 a, int256 b) public pure returns (int256) {
        return a + b;
    }

    // This is not
    function addNotPure(int256 a, int256 b) public returns (int256) {
        aa[50] = a + b;
        return aa[50];
    }
}

contract StateMutabliityTest {
    mapping(address => uint256) testajalah;

    function notPure(uint256 a, uint256 b) public returns (uint256) {
        testajalah[address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)] = a * b;
        return testajalah[address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4)];
    }
}

contract StateMutabilityView {
    int256 c = 10;

    function add(int256 a, int256 b) public pure returns (int256) {
        return a + b;
    }

    // This is a view function, but it's not a pure function
    function addView(int256 a) public view returns (int256) {
        // c is outside the function, and this is using information outside this function
        // so not pure, but we're not modifying the information, so it's view
        return a + c;
    }

    // This is neither pure nor view
    function addNotPure(int256 a, int256 b) public returns (int256) {
        // c is outside the function and we're modyfing the information
        c = a + b;
        return c;
    }
}

contract Constructor {
    uint256 public a;

    constructor(uint256 _a) {
        a = _a;
    }
}

contract Constructor2 {
    constructor() {}
}

contract ErrorHandlingRequire {
    address a = address(0x123);

    function buy(uint256 amount) public payable {
        require(a == msg.sender, "Not authorized");
        require(msg.value >= amount, "Insufficient funds");
    }
}

contract SpecialVariableMsg{
    address a = address(0x123);

    function buy(uint amount) public payable {
        require(a == msg.sender, "Not authorized");
    }
}