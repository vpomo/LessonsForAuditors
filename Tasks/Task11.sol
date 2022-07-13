// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract Task11 {

    struct Snapshot {
        uint256 createTime;
        uint256 balance;
        Operator operator;
    }

    enum Operator {Binance, OKX, Kucoin, Kraken, Bitfinex}

    Snapshot[] private snapshots;

    event AddSnapshot(
        address indexed sender,
        uint256 createTime,
        uint256 balance,
        Operator operator
    );

    function addSnapshot(uint256 balance, Operator operator) external {
        uint256 createTime = block.timestamp;
        require(Operator.Kraken != operator, "Task10: this operator is temporarily unavailable");
        snapshots.push(Snapshot(createTime, balance, operator));
        emit AddSnapshot(msg.sender, createTime, balance, operator);
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