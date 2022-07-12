// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Task05 {

    mapping (address=>mapping(uint256=>bool)) depositType;

    function setDepositTypeEnable(address _user, uint256 _type, bool _active) external {
        require(_user != address(0));
        depositType[_user][_type] = _active;
    }

    function getDepositTypeEnable(address _user, uint256 _type) external view returns(bool) {
        require(_user != address(0));
        return depositType[_user][_type];
    }
}
