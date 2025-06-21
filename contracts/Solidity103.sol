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

contract MsgValueExample {
    uint256 public totalDonations;

    function donate() public payable {
        totalDonations += msg.value;
    }
}

// Function Payment Example
contract Bank {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
}

contract User {
    Bank public bank;

    constructor(address _bankAddress) {
        bank = Bank(_bankAddress);
    }

    function depositToBank() public payable {
        bank.deposit{value: 5}();
    }
}

// Unit 3 - block
contract BlockNumberExample {
    uint256 a = 1;

    // the block number increment by 1 at every function call in Remix
    function showCurrentBlock() public returns (uint256) {
        a = a + 1;
        return block.number;
    }
}

contract BlockTimestamp {
    function showCurrentBlockTimestamp() public view returns (uint256) {
        return block.timestamp;
    }
}

// Unit 4 - Event
contract EventDefineExample {
    event LogValue(uint256 value);
}

contract EventEmitExample {
    event LogValue(uint256 value);

    function triggerLogValue(uint256 _value) public {
        emit LogValue(_value);
    }
}

contract EventIndexed {
    event MyEvent(address indexed sender, uint256 value);

    function triggerMyEvent(address _sender, uint256 _value) public {
        emit MyEvent(_sender, _value);
    }
}

// Unit 5 - Contract Interaction
// Contract Define Example
contract ContractA {
    uint256 public data;
}

contract ContractB {
    // Defines a contract type variable of ContractA
    ContractA public contractA;
    ContractA public contractAA;

    constructor(address _contractA) {
        // Instantiate the incoming contract address as the ContractA contract and assign it to the contractA variable
        contractA = ContractA(_contractA);
        contractAA = new ContractA();
    }
}

// Contract Function Call Example
contract Token {
    mapping(address => uint256) public balances;
    bool public transferCalled = false;

    function transfer(address to, uint256 amount) public {
        // Implement transfer logic...
        transferCalled = true;
    }
}

contract Wallet {
    Token public token;

    constructor(Token _token) {
        token = _token;
    }

    function transferTokens(address to, uint256 amount) public {
        token.transfer(to, amount);
    }
}

// Contract Access Variables Example
contract ThisToken {
    uint256 public totalSupply;

    constructor(uint256 _totalSupply) {
        totalSupply = _totalSupply;
    }
}

contract TokenReader {
    ThisToken public token;

    constructor(ThisToken _token) {
        token = _token;
    }

    function readTotalSupply() public view returns (uint256) {
        return token.totalSupply();
    }
}

// Unit 6 - Enum
contract EnumDefineExample {
    enum City {
        NewYork,
        Tokyo,
        Shanghai
    }
}

contract EnumAssignValueExample {
    enum City2 {
        NewYork,
        Tokyo,
        Shanghai
    }

    City2 public favoriteCity;

    function setFavoritCity() public {
        favoriteCity = City2.Tokyo;
    }
}

contract EnumIntegerExample {
    enum ExampleEnum {
        Value1,
        Value2,
        Value3
    }

    function getMinMax() public pure returns (ExampleEnum, uint256) {
        uint256 minValue = uint256(type(ExampleEnum).min);
        uint256 maxValue = uint256(type(ExampleEnum).max);
        ExampleEnum e = ExampleEnum(minValue);
        return (e, maxValue);
    }
}

// Unit 7 - Function Modifier
contract FunctionModifierDefineExample {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _; // We will explain this in the next chapter
    }
}

contract FunctionModifierUnderscoreExample {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }
}

contract FunctionModifierUsage {
    uint256 public value;

    modifier greaterThanValue(uint256 _value) {
        require(_value > value, "Input should be greater than value.");
        _;
    }

    function setValue(uint256 _value) public greaterThanValue(_value) {
        value = _value;
    }
}

contract FunctionModifierMultipleModifier {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier notNull(address newOwner) {
        require(
            newOwner != address(0),
            "New owner's address must not be zero."
        );
        _;
    }

    function changeOwner(address newOwner) public onlyOwner notNull(newOwner) {
        owner = newOwner;
    }
}
