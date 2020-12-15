// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.7.0;

contract Task06 {

    mapping(address => uint256) public deposits;
    address payable public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Task06: not owner");
        _;
    }

    constructor (address payable _owner) public {
        require(_owner != address(0));
        owner = _owner;
    }

    receive() external payable {
        deposits[owner] = deposits[owner] + msg.value;
    }

    function contractBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function walletBalance(address _wallet) external view returns(uint256) {
        return deposits[_wallet];
    }

    function getUserDeposit() external {
        uint256 value = deposits[msg.sender];
        require(contractBalance() >= value);
        deposits[msg.sender] = 0;
        msg.sender.transfer(value);
    }

    function getOwnerDeposit() external onlyOwner {
        uint256 value = deposits[msg.sender];
        require(contractBalance() >= value);
        deposits[owner] = 0;
        bool isSend = owner.send(value);
        require(isSend, "Task06: failure to send ETН");
    }

    function setDeposit() external payable {
        deposits[msg.sender] = deposits[msg.sender] + msg.value;
    }

}
