// SPDX-License-Identifier: GPL-3.0
//https://shasta.tronscan.org/#/address/TSkfZFsghmBkMAK8vHjFVyj9zNWaAcmG73

pragma solidity >=0.5.0 <0.7.0;

contract SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }

}

contract Task05 is SafeMath {

    function checkAdd(uint256 valueA, uint256 valueB) external pure returns (uint256) {
        return add(valueA, valueB);
    }

    function checkSub(uint256 valueA, uint256 valueB) external pure returns (uint256) {
        return sub(valueA, valueB);
    }

}