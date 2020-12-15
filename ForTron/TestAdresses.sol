// SPDX-License-Identifier: GPL-3.0
//https://shasta.tronscan.org/#/contract/TQqkKD9niD7aAsQLDtBGPPx3kbn2iDjmPK/code
//https://shasta.tronscan.org/#/tools/tron-convert-tool

pragma solidity >=0.5.0 <0.7.0;

contract TestAdresses {

    address private wallet;

    function setAddressWallet(address _addressValue) external {
        wallet = _addressValue;
    }

    function setBytesWallet(bytes calldata _bytesValue) external {
        wallet = bytesToAddress(_bytesValue);
    }

    function getWallet() external view returns (address) {
        return wallet;
    }

    function bytesToAddress(bytes memory source) private pure returns (address parsedAdress) {
        assembly {
            parsedAdress := mload(add(source, 0x14))
        }
    }
}
