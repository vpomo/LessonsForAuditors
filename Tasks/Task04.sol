// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Task04 {

    uint256[] private array;

    function getArray() external view returns(uint256[] memory) {
        return array;
    }

    function add(uint256 _number) external {
        array.push(_number);
    }

    function deleteLast() public {
        array.pop();
    }

    function deleteByIndex(uint256 _index)  external {
        if (_index >= array.length) return false;

        for (uint256 i = _index; i < array.length-1; i++){
            array[i] = array[i+1];
        }

        deleteLast();
    }
}
