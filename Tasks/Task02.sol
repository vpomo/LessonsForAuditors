// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.7.0;

contract Task02 {

    uint8 private a;
    uint8 private b;

    function setAB(uint8 valueA, uint8 valueB) external {
        a = valueA;
        b = valueB;
    }

    function isAddOverflow() external view returns(bool isOverflow, uint8 result) {
        result = a + b;
        if (a > b) {
            isOverflow = result < a;
        } else {
            isOverflow = result < b;
        }
    }

    function isSubOverflow() external view returns(bool isOverflow, uint8 result) {
        result = a - b;
        isOverflow = result > a;
    }

}
