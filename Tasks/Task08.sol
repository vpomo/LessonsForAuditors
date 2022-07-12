// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract Task08 {

    mapping(address => uint256) public deposits;
    address payable public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Task06: not owner");
        _;
    }

    constructor (address payable _owner) {
        require(_owner != address(0));
        owner = _owner;
    }

    receive() external payable {
        deposits[owner] = deposits[owner] + msg.value;
    }

    function deposit() external payable {
        deposits[msg.sender] = deposits[msg.sender] + msg.value;
    }

    function contractBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function userBalance(address _wallet) external view returns(uint256) {
        return deposits[_wallet];
    }

    function userWithdraw() external {
        uint256 value = getDepositValue(msg.sender);
        bool isSend = payable(msg.sender).send(value);
        require(isSend, "Task08: Failure to transfer ETH");
    }

    function ownerWithdraw() external onlyOwner {
        uint256 value = getDepositValue(msg.sender);
        payable(msg.sender).transfer(value);
    }

    function getDepositValue(address _user) private returns(uint256) {
        uint256 value = deposits[_user];
        require(contractBalance() >= value && value > 0);
        deposits[_user] = 0;
        return value;
    }
}
