pragma solidity 0.8.9;

contract Ballot {
    
    // VARIABLES
    
    struct vote {
        address voterAddress;
        bool choice ;
    }
    
    struct voter {
        string voterName;
        bool voted;
        bool exists;
    }
    
    uint private countResult  = 0;
    uint public finalResult = 0;
    uint public totalVoter = 0;
    uint public totalVote = 0;
    
    address ballotOficialAddress;
    string public ballotOficialName;
    string public proposal;
    
    mapping(uint => vote) private votes;
    mapping(address => voter) private voterRegister;
    
    enum State {Created, Voting, Ended}
    State public state;
    
    
    // MODIFIERS
    
    modifier condition(bool _condition) {
        require(_condition);
        _;
    }
    
    modifier onlyOfficial() {
        require(msg.sender == ballotOficialAddress);
        _;
    }
    
    modifier inState(State _state) {
        require(state == _state);
        _;
        
    }
    
    // EVENTS
    
    // FUNCTIONS
    
    constructor(
        string memory _ballotOficialName,
        string memory _proposal
        ) 
            {ballotOficialName = _ballotOficialName;
            proposal = _proposal;
            ballotOficialAddress = msg.sender;
            state = State.Created;
            
    }

    function addVoter(address _voterAddress, string memory _voterName)    // adicionar pessoas para a votação
        public
        inState(State.Created)
        onlyOfficial
        {
        voter memory v;
        v.voterName = _voterName;
        v.voted = false;
        v.exists = true;
        voterRegister[_voterAddress] = v;
        totalVoter++;
    }
    
    function startVote()
        private
        inState(State.Created)
        onlyOfficial
        {
            state = State.Voting;
    }
    
    
  
    function doVote(bool _choice)
        public
        inState(State.Voting)
        returns (bool voted)
    {
        bool found = false;
        
        if (voterRegister[msg.sender].exists = true
        && !voterRegister[msg.sender].voted) 
        {
              voterRegister[msg.sender].voted = true;
              vote memory v;
              v.voterAddress = msg.sender;
              v.choice = _choice;
              if (_choice) {
                  countResult++;
              }
              
              votes[totalVote] = v;
              totalVote++;
              found = true;
            }
        return found;
            
    }
    
    function endVote() public {}
    
    
    
    
    
    
    
}
