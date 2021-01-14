// SPDX-License-Identifier: MIT
/// Token 0xc982a0c3d0d3B882e95e275D1271500B2551Bd9c

pragma solidity >=0.6.0 <0.8.0;
contract D {
  uint public n;
  address public sender;

  function delegatecallSetN(address _e, uint _n) external {
      bytes memory data = abi.encodeWithSelector(bytes4(keccak256("setN(uint256)")), _n);
     (bool success, bytes memory returnedData) = _e.delegatecall(data);
     require(success);
  }
}

contract E {
  uint public n;
  address public sender;
  function setN(uint _n) external {
    n = _n;
    sender = msg.sender;
  }
}
