// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Task01 {

    string private message;

    function setMessage(string memory value) external {
        message = value;
    }

    function getMessage() external view returns (string memory) {
        return message;
    }
}
