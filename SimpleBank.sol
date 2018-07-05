pragma solidity ^0.4.24;



contract SimpleBank {
    
  address private owner;
  mapping(address=> uint) private deposits;
  
  event Deposit(address fromAddr, uint value);
    event Withdraw(address fromAddr, uint value);
  
    constructor() {
        owner = msg.sender;
    }
    
    function depositFunds() public payable returns (uint)  {
        require(msg.value>0);
        deposits[msg.sender]+=msg.value;
        
        // Invoke the event to log its arguments
        emit Deposit(msg.sender,msg.value); 
    }
    
       function withdrawFunds(uint value) public returns (uint)  {
        require(deposits[msg.sender]>=value);
        deposits[msg.sender]-=value;
        msg.sender.transfer(value);
        // Invoke the event to log its arguments
        emit Withdraw(msg.sender,value); 
    }
    
      
    function getBalance() public view returns (uint)  {
        return deposits[msg.sender];
    }

}