// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

interface ITask07 {

    function setDepositTypeEnable(address _user, uint256 _type, bool _premition ) external;

    function getDepositTypeEnable(address _user, uint256 _type) external view returns(bool);

    function setContractSetter(address _contract) external;
}


contract Task07 is ITask07 {

    mapping (address=>mapping(uint256=>bool)) depositType;

    address setterContract;

    modifier onlyContractSetter() {
        require(msg.sender == setterContract, "Caller is not the setter contract");
        _;
    }

    function setDepositTypeEnable(address _user, uint256 _type, bool _active ) onlyContractSetter external {
        require(_user != address(0));
        depositType[_user][_type]=_active;
    }

    function getDepositTypeEnable(address _user, uint256 _type) external view returns(bool) {
        require(_user != address(0));
        return depositType[_user][_type];
    }

    function setContractSetter(address _contract) external {
        require(_contract != address(0));
        setterContract = _contract;
    }

}

contract SetterContract {

    ITask07 iTask;

    constructor(address _iTask) {
        require(address(_iTask) != address(0), "CheckInterface: the parameter cannot be zero");
        iTask = ITask07(_iTask);
        iTask.setContractSetter(address(this));
    }

    function setMyTypeEnable(uint256 _type, bool _active) external {
        require(address(iTask) != address(0), "CheckInterface: the interface must exist");
        iTask.setDepositTypeEnable(msg.sender, _type, _active);
    }
}