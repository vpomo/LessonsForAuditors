// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.5.0;

contract Task02 {

    uint8 public result;
    bool public isOverflow;

    uint8 public a;
    uint8 public b;

    function setAB(uint8 valueA, uint8 valueB) external {
        a = valueA;
        b = valueB;
    }

    function setAddOverflow() external {
        result = a + b;
        if (a > b) {
            isOverflow = result < a;
        } else {
            isOverflow = result < b;
        }
    }

    function setSubOverflow() external {
        result = a - b;
        isOverflow = result > a;
    }
}
