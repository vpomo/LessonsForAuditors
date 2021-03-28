// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.3;

contract GovernanceAccess {
    address public governance;

    constructor (address _governance) {
        require(_governance != address(0), "Address cannot be zero");
        governance = _governance;
    }
    
    modifier onlyGovernance() {
        require(governance == msg.sender, "onlyGovernance: caller is not the governance");
        _;
    }
}

abstract contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor (address newOwner) {
        _owner = newOwner;
        emit OwnershipTransferred(address(0), newOwner);
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract SameContract is GovernanceAccess {
    
    string public description;
    address public user;
    bool public isFinished;
    
    event Received(address indexed from, uint256 value);
    event Refunded(address indexed to, uint256 value);

    constructor(string memory _description, address _governance, address _user) GovernanceAccess(_governance) {
        require(_user != address(0), "Address cannot be zero");
        description = _description;
        user = _user;
    }
    
    function sayHello() onlyGovernance external view returns (string memory) {
        return string(abi.encodePacked("Hello from: ", description));
    }
    
    function withdraw() onlyGovernance external returns(uint256 _amount) {
        require(!isFinished);
        _amount = address(this).balance;
        if (_amount > 0) {
            isFinished = true;
            payable(user).transfer(_amount);
            emit Refunded(user, _amount);
        }
    }
    
    receive() payable external {
        require(!isFinished);
        emit Received(msg.sender, msg.value);
    }
}


contract Factory is GovernanceAccess {
    uint256 contractCount;

    constructor(address _governance) GovernanceAccess(_governance) {
    }

    function makeSameContract(address _user, string memory _description) internal returns(address _contract) {
        contractCount++;
        SameContract sameContract = new SameContract(_description, governance, _user);
        _contract = address(sameContract);
    }
}


interface ISameContract {
    
    function sayHello() external view returns (string memory);
    
    function withdraw() external returns(uint256 _amount);
    
}


contract Governance is Factory, Ownable {
    mapping (address => address[]) private contracts;
    
    constructor() Factory(address(this)) Ownable(msg.sender) {
    }
    
    function makeNewContract(address _user, string memory _description) onlyOwner external {
        address _contract = makeSameContract(_user, _description);
        contracts[_user].push(_contract);
    }
    
    function getHello(address _user, uint256 _number) external view returns(string memory) {
        return ISameContract(contracts[_user][_number]).sayHello();
    }
    
    function getUserContracts(address _user) public view returns(address[] memory _contracts) {
       _contracts = contracts[_user];
    }
    
    function withdraw(address _user, uint256 _contractNumber) external {
        address[] memory _userContracts = getUserContracts(_user);
        if (_userContracts.length > _contractNumber) {
            ISameContract(_userContracts[_contractNumber]).withdraw();
        }
    }
    
}
