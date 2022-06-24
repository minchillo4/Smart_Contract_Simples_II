//SDPX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./simplestorage.sol";

    contract StorageFactory {
//variables
        SimpleStorage[] public simpleStorageList;
// create contract and keep 


        function newSimpleStorage() public {
            SimpleStorage simpleStorage = new SimpleStorage();
            simpleStorageList.push(simpleStorage);
           
        }

       




    }
