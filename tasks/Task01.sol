// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;

contract Task01 {

    string private message;

    function setMessage(string memory value) external {
        message = value;
    }

    function getMessage() external view returns (string memory) {
        return message;
    }

}
