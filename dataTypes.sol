pragma solidity 0.8.9;


contract dataTypes {
    
    
    mapping (address => Players) public players;
    uint public playerCount;
    
    
    enum Level {
        Newbie,
        Novice,
        Intermediate,
        Advanced,
        Expert
    }
    
    struct Players {
        address playerAddress;
        Level playerLevel;
        string firstName;
        string lastName;
    }
    
    function addPlayer (string memory _firstName, string memory _lastName) public {
        playerCount += 1;
        players[msg.sender] = Players(msg.sender, Level.Expert, _firstName, _lastName);
    }
        
        
    function returnPlayerAdress(address _playerAdress) public returns (Level) {
        return players[_playerAdress].playerLevel;
    }
        
        
        
    }
    
    
