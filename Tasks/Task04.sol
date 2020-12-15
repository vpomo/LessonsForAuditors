// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.7.0;

contract Task04 {

    mapping (address=>mapping(uint256=>bool)) depositType;

    function setDepositType(address _user, uint256 _type, bool _premition ) external {
        require(_user != address(0));
        depositType[_user][_type]=_premition;
    }

    function getDepositType(address _user, uint256 _type) external view returns(bool) {
        require(_user != address(0));
        return depositType[_user][_type];
    }

}
