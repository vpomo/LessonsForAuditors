// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract Task10 {

    struct Snapshot {
        uint256 createTime;
        uint256 balance;
    }

    Snapshot[] private snapshots;

    event AddSnapshot(
        address indexed sender,
        uint256 createTime,
        uint256 balance
    );

    function addSnapshot(uint256 balance) external {
        uint256 createTime = block.timestamp;
        snapshots.push(Snapshot(createTime, balance));
        emit AddSnapshot(msg.sender, createTime, balance);
    }

    function getAll() external view returns(Snapshot[] memory) {
        return snapshots;
    }

    function removeLast() public {
        snapshots.pop();
    }

    function removeByIndex(uint256 index) external {
        if (index >= snapshots.length) return;

        for (uint i = index; i < snapshots.length - 1; i++){
            snapshots[i] = snapshots[i+1];
        }
        removeLast();
    }
}