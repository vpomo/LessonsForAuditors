// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;


contract D {
    
  uint public n;
  address public sender;
  
  event LogResult(bool result, bytes returnData);

  function callSetN(address _contractE, uint _n) external {
     (bool success, bytes memory returnData) = _contractE.call(abi.encodeWithSignature("setN(uint256)", _n));
     emit LogResult(success, returnData);
    // call from user: E's storage is set, D is not modified 
  }

  function delegatecallSetN(address _contractE, uint _n) external {
     (bool success, bytes memory returnData) = _contractE.delegatecall(abi.encodeWithSignature("setN(uint256)", _n));
     emit LogResult(success, returnData);
     // call from user: D's storage is set, E is not modified 
     // msg.sender is user's wallet
     
     // call from contract C: D's storage is set
     // msg.sender is contract C
  }
}

contract E {
  uint public n;
  address public sender;

  function setN(uint _n) external {
    n = _n;
    sender = msg.sender;
    // msg.sender is D if invoked by D's callSetN. E's storage is updated
    // msg.sender and n not modified then D's delegatecallSetN. E's storage not updated
    
    // msg.sender is C if invoked by C.foo(). E's storage not updated

  }
}

contract C {
    function checkDelegateCallContractD(D _d, address _e, uint _n) external {
        _d.delegatecallSetN(_e, _n);
        // D's storage updated, E's storage not modified
        // msg.sender is contract C
    }
    
    function checkCallContractD(D _d, address _e, uint _n) external {
        _d.callSetN(_e, _n);
        // D's storage not updated, E's storage is modified
        // msg.sender is contract D
    }

}