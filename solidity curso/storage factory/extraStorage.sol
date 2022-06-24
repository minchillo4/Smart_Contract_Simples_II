//SDPX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./simplestorage.sol";

contract ExtraStorage is SimpleStorage {

     function store(string memory _name, uint256 _age) public pure override {
           _name = "lucas";
           _age =  24;
    
        }




    





}
