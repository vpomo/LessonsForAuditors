// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.5.0;

library SafeMath {

    function add(uint8 a, uint8 b) internal pure returns (uint8) {
        uint8 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint8 a, uint8 b) internal pure returns (uint8) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint8 c = a - b;

        return c;
    }
}

contract Task14 {

    using SafeMath for uint8;

    uint8 public result;

    uint8 public a;
    uint8 public b;

    function setAB(uint8 valueA, uint8 valueB) external {
        a = valueA;
        b = valueB;
    }

    function isAddOverflow() external {
        result = a.add(b);
    }

    function isSubOverflow() external {
        result = a.sub(b);
    }
}
