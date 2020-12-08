// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;
pragma experimental ABIEncoderV2;

contract Task03 {

    string EMPTY = "";
    string[] private messageArray;

    function addElement(string memory _value) external {
        messageArray.push(_value);
    }

    function removeElement() external returns (bool) {
        if (messageArray.length > 0) {
            messageArray.pop();
            return true;
        } else {
            return false;
        }
    }

    function readAll() external view returns (string[] memory) {
        return messageArray;
    }

    function readById(uint256 _id) external view returns (string memory) {
        if (messageArray.length > _id) {
            return messageArray[_id];
        }
        return EMPTY;
    }

    function removeAll() external returns (bool) {
        if (messageArray.length > 0) {
            delete messageArray;
            return true;
        } else {
            return false;
        }
    }

    function removeById(uint256 _id) external returns (string[] memory) {
        uint256 length = messageArray.length;
        if (length > 0) {
            for (uint256 i = _id; i < length-1; i++){
                messageArray[i] = messageArray[i+1];
            }
            messageArray.pop();
            return messageArray;
        } else {
            return emptyArray();
        }
    }

    function emptyArray() private pure returns (string[] memory) {
        return new string[](0);
    }

}