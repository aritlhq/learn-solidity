// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract LearningStrings {
    string car = "BMW";
    string text;

    // assign a value to a string variable using the function
    function setText() public returns (string memory) {
        text = "Hello world baby!";
        return car;
    }
}

contract StringConcatenation {
    string public greeting = "Hello ...";
    string public name = "Alice";

    string result = string.concat(greeting, name);

    string public message;

    function setMessage() public {
        message = string.concat("Hello ", name);
    }
}

contract DataLocationStorage {
    string name = "Hello World!";

    function update() public {
        name = "Hello";
    }
}

contract DataLocationStorage2 {
    string name = "Hello";

    function update() public {
        string memory newName = "Hellow~";

        name = newName;
    }
}

contract DataLocationMemory {
    string public name;
    uint256 public score;

    function operate() public {
        score = 10;
        name = "Jane";

        string memory tempName = "Joe";
        tempName = name;
    }
}

contract SturctDefine {
    struct Student {
        string name;
        uint256 studentId;
        uint256 grade;
    }
}

contract StructInitalize {
    struct Student {
        string name;
        uint256 studentId;
    }

    Student public a = Student("Jane", 100);
    Student public b = Student("Luca", 200);
}

contract StructUpdate {
    struct Student {
        string name;
        uint256 studentId;
    }

    Student a = Student("Janeee", 100);
    Student b = Student("Lucaaa", 200);

    function updateStudentInfo() public {
        a.name = "Jhon Dhoe";
        b.studentId = 1023;
    }
}

contract DynamicArrayDefine {
    uint256[] uintArr;
    string[] stringArr;
}

contract DynamicArrayPush {
    uint256[] uintArr;

    function addElement(uint256 newValue) public {
        uintArr.push(newValue);
    }
}

contract DynamicArrayPop {
    uint256[] uintArr;

    function addElement(uint256 newValue) public {
        uintArr.push(newValue);
    }

    function removeElement() public {
        uintArr.pop();
    }
}

contract DynamicArrayLength {
    uint256[] uintArr;

    function addElement(uint256 newValue) public {
        uintArr.push(newValue);
    }

    function getArrayLength() public view returns (uint256) {
        return uintArr.length;
    }
}

contract DynamicArrayAccess {
    uint256[] uintArr;

    function addElement(uint256 newValue) public {
        uintArr.push(newValue);
    }

    function getFirstElement() public view returns (uint256) {
        return uintArr[0];
    }
}

contract BytesDefine {
    string public name;
    bytes public stringArr;

    constructor() {
        name = "Hello World";
        stringArr = bytes(name);
        name = string(stringArr);
    }
}

contract StringLength {
    function getlength(string memory str) public pure returns (uint256) {
        bytes memory bytesStr = bytes(str);

        return bytesStr.length;
    }

    string name = "The daughter";
    string testS;
    bytes testB;
    uint256 l;

    function test() public {
        testS = string.concat(name, "hello");
        l = bytes(testS).length;
        testB = bytes(testS);
    }
}

contract StringLength2 {
    string hi = "hello";
    uint256 length = bytes(hi).length;

    function getLengthOfString() public view returns (uint256) {
        return length;
    }
}

contract FlowControlIfElse {
    uint256 value = 10;

    function checkValue() public view returns (string memory) {
        if (value == 10) {
            return "Value is equal to 10";
        } else {
            return "Value is not equal to 10";
        }
    }
}

contract FlowControlWhile {
    uint256[] public numbers;

    function fillNumbers(uint256 n) public {
        uint256 i = 0;
        while (i < n) {
            numbers.push();
            i++;
        }
    }

    function getNumbers() public view returns (uint256[] memory) {
        return numbers;
    }
}

contract FlowControlDoWhile {
    uint256[] public numbers;

    function fillNumbers(uint256 n) public {
        uint256 i = 0;
        do {
            numbers.push();
            i++;
        } while (i < n);
    }

    function getNumbers() public view returns (uint256[] memory) {
        return numbers;
    }
}

contract FlowControlFor {
    uint256[] public numbers;

    function fillNumbers(uint256 n) public {
        for (uint256 i = 0; i < n; i++) {
            numbers.push();
        }
    }

    function getNumbers() public view returns (uint256[] memory) {
        return numbers;
    }
}
