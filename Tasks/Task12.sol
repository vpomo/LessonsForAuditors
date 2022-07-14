// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract Task12 {

    struct Snapshot {
        uint256 updateTime;
        uint256 balance;
    }

    Snapshot[] private snapshots;

    event AddSnapshot(
        address indexed sender,
        uint256 updateTime,
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

        for (uint256 i = index; i < snapshots.length - 1; i++){
            snapshots[i] = snapshots[i+1];
        }
        removeLast();
    }

    function allIncreaseBalance(uint256 amount) external {
        uint256 length = snapshots.length;
        if (0 == length) return;

        for (uint256 i = 0; i < length; i++){
            snapshots[i].balance += amount;
            snapshots[i].updateTime = block.timestamp;
        }
    }

    function allDecreaseBalance(uint256 amount) external {
        uint256 length = snapshots.length;
        if (0 == length) return;
        uint256 i = 0;

        while (i < length){
            if (snapshots[i].balance >= amount) {
                snapshots[i].balance -= amount;
            } else {
                snapshots[i].balance = 0;
            }
            snapshots[i].updateTime = block.timestamp;
            i++;
        }
    }
}