// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "./OtherContract.sol";

/*
=============== Syllabus ===============

Error Reporting:
- revert
- error
- revert error
- assert

Error Handling:
- try catch
- try catch-return
- try catch-catch error
- try catch-catch

Library:
- library-define
- library-call
- library-usage
- import

Inheritance 1:
- inheritance - Contract Inheritance
- inheritance - constructor
- inheritance - override

Inheritance 2:
- inheritance - virtual
- inheritance - super
- inheritance - Multiple inheritance

Interface: 
- interface - define
- interface - Interface Inheritance
- interface - usage

Wrap Up:
- abstract contract
- hash
*/

/* 
Unit 1 - Error Reporting 
*/
contract RevertExample {
    mapping(address => uint256) balanceOf;

    function deposit(uint256 amount) public payable {
        //Use require to check parameters
        require(
            msg.value == amount,
            "Deposit amount must be equal to the sent value"
        );
        uint256 oldBalance = balanceOf[msg.sender];
        balanceOf[msg.sender] += amount;
    }

    function withdraw(uint256 amount) public {
        //When using branches to determine multiple possible error situations, reverse can be used
        if (amount <= 0) {
            revert("Invalid withdrawal amount");
        } else if (balanceOf[msg.sender] < amount) {
            revert("Insufficient balance for withdrawal");
        }
        payable(msg.sender).transfer(amount);
        uint256 oldBalance = balanceOf[msg.sender];
        balanceOf[msg.sender] -= amount;
    }
}

contract ErrorExample {
    mapping(address => uint256) private balances;

    // Custom Error Type InsufficientFunds
    error InsufficientFunds(uint256 requested, uint256 available);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        if (amount > balances[msg.sender]) {
            // it will be explained in the next lessons
            revert InsufficientFunds(amount, balances[msg.sender]);
        }
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance(address account) public view returns (uint256) {
        return balances[account];
    }
}

contract RevertErrorExample {
    mapping(address => uint256) private balances;

    //Custom Error Type InsufficientFunds
    error InsufficientFunds(uint256 requested, uint256 available);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        if (amount > balances[msg.sender]) {
            revert InsufficientFunds(amount, balances[msg.sender]);
        }
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance(address account) public view returns (uint256) {
        return balances[account];
    }
}

contract AssertExample {
    mapping(address => uint256) balanceOf;

    function deposit(uint256 amount) public payable {
        //using require to check parameters
        require(
            msg.value == amount,
            "Deposit amount must be equal to the sent value"
        );
        uint256 oldBalance = balanceOf[msg.sender];
        balanceOf[msg.sender] += amount;

        //using assert to check the correctness of code execution(here to prevent overflow)
        assert(balanceOf[msg.sender] > oldBalance);
    }

    function withdraw(uint256 amount) public {
        //Using revert statements to handle multiple potential error scenarios in if-else statements.
        if (amount <= 0) {
            revert("Invalid withdrawal amount");
        } else if (balanceOf[msg.sender] < amount) {
            revert("Insufficient balance for withdrawal");
        }
        payable(msg.sender).transfer(amount);
        uint256 oldBalance = balanceOf[msg.sender];
        balanceOf[msg.sender] -= amount;

        //using assert to check the correctness of code execution (here to prevent overflow)
        assert(balanceOf[msg.sender] >= oldBalance);
    }
}

/* 
Unit 2 - Error Handling
*/

// Try Catch Example
contract TryCatchExample {
    event Success();
    event Failure();

    function sendEther(address contractB) public {
        try B(contractB).dosome() {
            emit Success();
            //send success
        } catch {
            emit Failure();
            //send failed
        }
    }
}

contract B {
    function dosome() public {
        revert();
    }
}

// Try Catch Return Example
contract TryCatchReturnExample {
    bool public val = false;

    function sendEther(address contractB) public {
        try B2(contractB).dosome() returns (bool ret) {
            // send success
            val = ret;
        } catch {
            //send failed
        }
    }
}

contract B2 {
    function dosome() public pure returns (bool) {
        return true;
    }
}

// Try Catch - Catch Error Example
error SpecificNumerator(string msg);

contract ErrorHandlingExample {
    uint256 public result;

    function divide(uint256 numerator, uint256 denominator) external {
        try this.safeDivide(numerator, denominator) returns (uint256 quotient) {
            result = quotient;
        } catch Error(
            string memory /*reason*/
        ) {
            //  handle revert() and require()
            result = 11;
        } catch (
            bytes memory /*lowLevelData*/
        ) {
            // handle custome error and others
            result = 22;
        }
    }

    function safeDivide(uint256 numerator, uint256 denominator)
        external
        pure
        returns (uint256)
    {
        require(denominator != 0, "Division by zero");
        if (numerator == 99) {
            revert("the numerator is 99");
        }

        if (numerator == 88) {
            revert SpecificNumerator("the numerator is 88");
        }

        assert(numerator >= denominator);

        return numerator / denominator;
    }
}

// Try Catch - Catch Example
error SpecificNumerator2(string msg);

contract TryCatchCatchExample {
    uint256 public result;

    function divide(uint256 numerator, uint256 denominator) external {
        try this.safeDivide(numerator, denominator) returns (uint256 quotient) {
            result = quotient;
        } catch Error(
            string memory /*reason*/
        ) {
            //  handle revert() and require()
            result = 11;
        } catch (
            bytes memory /*lowLevelData*/
        ) {
            // handle custome error and others
            result = 22;
        }
    }

    function safeDivide(uint256 numerator, uint256 denominator)
        external
        pure
        returns (uint256)
    {
        require(denominator != 0, "Division by zero");
        if (numerator == 99) {
            revert("the numerator is 99");
        }

        if (numerator == 88) {
            revert SpecificNumerator2("the numerator is 88");
        }

        assert(numerator >= denominator);

        return numerator / denominator;
    }
}

/* 
Unit 3 - Library
*/

library LibraryDefineExample {
    function square(uint256 x) external pure returns (uint256) {
        return x * x;
    }
}

// Library - Call Example
library MathLibrary2 {
    function square(uint256 x) external pure returns (uint256) {
        return x * x;
    }
}

contract LibraryCallExample {
    function calculateSquare(uint256 y) external pure returns (uint256) {
        // Calling functions in a Library contract.
        uint256 result = MathLibrary2.square(y);
        return result;
    }
}

// Library - Usage Example
library MathLibrary3 {
    function square(uint256 x) external pure returns (uint256) {
        return x * x;
    }
}

contract LibraryUsageExample {
    using MathLibrary3 for uint256;

    function calculateSquare(uint256 y) external pure returns (uint256) {
        // The variable 'y' is automatically  passed as the first parameter to the 'square' function.
        return y.square();
    }
}

contract ImportExample {
    // Use the contract we imported
    OtherContract public otherContract;

    constructor(address _otherContractAddress) {
        // create instances of other contracts
        otherContract = OtherContract(_otherContractAddress);
    }

    // Call function of other contracts
    function callOtherContractFunction() external view returns (uint256) {
        // Use imported contract instances to call functions
        return otherContract.someFunction();
    }
}

/*
Unit 4 - Inheritance 1
*/

// Inheritance - Contract Inheritance Example
contract ParentContract {
    // State variables and functions in the parent contract.
    uint256 public parentVariable = 1;

    function parentFunction() public pure returns (string memory) {
        return "Hello from parent contract!";
    }
}

contract ChildContract is ParentContract {
    // State variables and functions in the child contract.
    uint256 public childVariable;

    function childFunctionCallParentFunction()
        public
        pure
        returns (string memory)
    {
        return parentFunction();
    }

    function childFunctionUsingParentVariable() public {
        childVariable = parentVariable;
    }
}

// Inheritance - Constructor Example
contract D {
    uint256 public bValue;

    constructor(uint256 _value) {
        bValue = _value;
    }
}

contract InheritanceConstructor is D {
    uint256 public aValue;

    constructor(uint256 _valueA, uint256 _valueB) D(_valueB) {
        aValue = _valueA;
    }
}

// Inheritance - Override Example
contract Animal {
    // The "virtual" keyword will be discussed in the next section.
    function makeSound() public virtual returns (string memory) {
        return "Animal Sound";
    }
}

contract Cat is Animal {
    // Override the parent's makeSound function
    function makeSound() public override returns (string memory) {
        return "Meow";
    }
}

contract Dog is Animal {
    // Override the parent's makeSound function.
    function makeSound() public override returns (string memory) {
        return "Woof";
    }
}

contract AnimalSounds {
    Animal public animal;

    constructor(Animal _animal) {
        animal = _animal;
    }

    function makeAnimalSound() public returns (string memory) {
        return animal.makeSound();
    }
}

/*
Unit 5 - Inheritance 2
*/
// Inheritance - Virtual Example
contract Shape {
    uint256 public sides;

    constructor() {
        sides = 0;
    }

    // Define the function to calculate the area as virtual, allowing it to be inherited.
    // the child contract can override it as needed.
    function getArea() public virtual returns (uint256) {
        return 0;
    }
}

contract InheritanceVirtualExample is Shape {
    uint256 private sideLength;

    constructor(uint256 _sideLength) {
        sideLength = _sideLength;
        sides = 4;
    }

    // The formula to calculate the area of a square is side * side.
    function getArea() public virtual override returns (uint256) {
        return sideLength * sideLength;
    }
}

contract Triangle is Shape {
    uint256 private base;
    uint256 private height;

    constructor(uint256 _base, uint256 _height) {
        base = _base;
        height = _height;
        sides = 3;
    }

    // The formula to calculate the area of a triangle is (base * height) / 2.
    function getArea() public virtual override returns (uint256) {
        return (base * height) / 2;
    }
}

// Inheritance - Super Example
contract Parent {
    function foo() public virtual returns (string memory) {
        return "Parent";
    }
}

contract Child is Parent {
    function foo() public override returns (string memory) {
        return super.foo();
    }
}

// Inheritance - Multiple Inheritance Example
contract Parent1 {
    function foo() public virtual returns (string memory) {
        return "Parent1";
    }
}

contract Parent2 {
    function foo() public virtual returns (string memory) {
        return "Parent2";
    }
}

contract InheritanceMultipleInheritanceExample is Parent1, Parent2 {
    // it will return Parent2.
    function foo() public override(Parent1, Parent2) returns (string memory) {
        return super.foo();
    }
}

/*
Unit 6 - Interface
*/
// Interface - Define Example
interface MyInterface {
    //Functions in interfaces must be defined as external,since the purpose of interfaces is to be used by external calls.
    // In function interfaces, parameter names can be omitted, and the syntax myFunction(uint256) is also valid.
    function myFunction(uint256 x) external returns (uint256);
}

// Implementing contract for the interface
contract MyContract {
    function myFunction(uint256 x) external returns (uint256) {
        // Implemention of function
        return x * 2;
    }
}

// Contract using the interface to call functions
contract CallerContract {
    MyInterface public myContract;

    // Pass the address of MyContract
    constructor(address contractAddress) {
        myContract = MyInterface(contractAddress);
    }

    // Call myFunction in MyContract through the interface (we will discuss interface calls in detail in the next section)
    function callInterface(uint256 value) public returns (uint256) {
        uint256 result = myContract.myFunction(value);
        return result;
    }
}

// Interface - Interface Inheritance Example
// Interface: Transferable Interface
interface Transferable {
    function deposit(uint256 amount) external returns (bool);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function getBalance() external view returns (uint256);
}

// Contract: BankAccount
// Inherits from the Transferable interface, which means our contract must include the transfer and getBalance functions.
contract BankAccount is Transferable {
    mapping(address => uint256) private balances;

    // Implement the deposit function
    function deposit(uint256 amount) external override returns (bool) {
        balances[msg.sender] += amount;
        return true;
    }

    // Implement the transfer function
    function transfer(address recipient, uint256 amount)
        external
        override
        returns (bool)
    {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        return true;
    }

    // Implement the getBalance function
    function getBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
}

// Interface - Usage Example
interface OtherContractInterface {
    function getValue() external view returns (uint256);

    function setValue(uint256 newValue) external;
}

// Contract A
contract ContractA {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue;
    }

    // Pass the address of contract B, then use the interface to call contract B's function
    function callGetValue(address contractBAddress)
        public
        view
        returns (uint256)
    {
        ContractB contractB = ContractB(contractBAddress);
        return contractB.getOtherContractValue();
    }
}

// Contract B
contract ContractB {
    // Variable of interface type, similar to contract variables
    OtherContractInterface public otherContract;

    // Assign the value in the constructor
    constructor(address otherContractAddress) {
        otherContract = OtherContractInterface(otherContractAddress);
    }

    // Use the interface to call the setValue function
    function callSetValue(uint256 newValue) public {
        otherContract.setValue(newValue);
    }

    function getOtherContractValue() public view returns (uint256) {
        return 5;
    }
}

/*
Unit 7 - Wrap Up
*/

// Abstract Contract Example
// Abstract contract
abstract contract Shark {
    // Abstract contracts can have variable definitions
    string public name;
    bool public hasEaten;

    event EatEvent(string name);

    // Abstract contracts can also have constructors
    constructor(string memory _name) {
        name = _name;
    }

    function speak() public virtual returns (string memory);

    function eat() public virtual {
        // Abstract contracts can include implementations
        // The specific function can be overridden in child contracts
        hasEaten = true;
    }
}

// Contract implementing the abstract contract
contract Duck is Shark {
    constructor(string memory _name) Shark(_name) {}

    function speak() public override returns (string memory) {
        return "Meow";
    }

    function eat() public override {
        // Override the eat function from the abstract contract
        // Provide specific eating function for cats
        super.eat();
        emit EatEvent(name);
        // Perform other eating operations for cats
    }
}

contract HashExample {
    // Receives a string parameter _message and returns a 32-byte hash value (of type bytes32).
    // Inside the function, we use the keccak256 function to perform a hash operation on the input string, and return the result.
    function hash(string memory _message) public pure returns (bytes32) {
        return keccak256(bytes(_message));
    }
}
