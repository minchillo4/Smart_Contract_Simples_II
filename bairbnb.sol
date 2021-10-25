pragma solidity 0.8.9;

contract airbnb {
    
    
    address  payable enderecoProprietario;
    address  payable enderecoLocatario;
    
    struct Flat {
        
        uint256 priceInWei;
        address locadorAtual;
        bool propDisponivel;
    }
         Flat[8] flatDb; 
         
         modifier landLordOnly () {
             require(msg.sender == enderecoProprietario);
             _;
         }
         
    constructor ()  {
        enderecoProprietario = payable(msg.sender);
        for (uint i = 0; i < 8; i++) {
            flatDb[i].propDisponivel = true;
            if ( i % 2 == 0) {
                flatDb[i].priceInWei = 0.1  ether;
            }
                else {
                    flatDb[i].priceInWei = 0.2 ether;
                }
                
            }
            
        }
        
        function getFlatAvailability (uint _flat) public view returns (bool) {
            return flatDb[_flat].propDisponivel;
        }
        
        function getFlatPrice (uint _flat) public view returns (uint) {
            return flatDb[_flat].priceInWei;
        }
        
        function getCurrentOccupant (uint _flat) public view returns (address) {
            return flatDb[_flat].locadorAtual;
        }
        
        function setFlatAvailability(uint _flat, bool _newAvailability) public landLordOnly {
            flatDb[_flat].propDisponivel = _newAvailability;
            if (_newAvailability) {
                flatDb[_flat].locadorAtual = address(0);
            }
        }
        
        function setFlatPrice(uint _flat, uint _priceInWei) public landLordOnly {
            flatDb[_flat].priceInWei = _priceInWei;
        }
        
        function rentAFlat (uint _flat) public payable returns(uint256) {
            enderecoLocatario =  payable(msg.sender);
            if (msg.value % flatDb[_flat].priceInWei == 0 && msg.value > 0 && flatDb[_flat].propDisponivel == true) {
                uint256 numberOfNightsPaid = msg.value / flatDb[_flat].priceInWei;
                flatDb[_flat].propDisponivel = false;
                flatDb[_flat].locadorAtual = enderecoLocatario;
                enderecoProprietario.transfer(msg.value);
                return numberOfNightsPaid;
            }
            else {
                enderecoLocatario.transfer(msg.value);
                return 0;
            
            }
        }   
}
