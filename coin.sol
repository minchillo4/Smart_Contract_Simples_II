pragma solidity >= 0.7.0 <0.9.0;

contract Coin {
    
    address public minter;
    mapping (address => uint) public addressToBalance;
    
    event sent (address _from, address _to, uint amount); 
    
    constructor() {
        minter = msg.sender;
    }
    
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        addressToBalance[receiver] += amount;
    }
    
    function send(address receiver, uint _amount) public {
        require(_amount <= addressToBalance[msg.sender], "Insufficient amount");
        addressToBalance[msg.sender] -= _amount;
        addressToBalance[receiver] += _amount;
        emit sent(msg.sender, receiver, _amount);
    }
    
    
    
    
}
