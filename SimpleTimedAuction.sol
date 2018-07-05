

pragma solidity ^0.4.24;



contract SimpleTimedAuction {
    
  address private owner;
  uint private initialTokenSupply;
  mapping(address=> uint) private deposits;
  uint  private contractCreationTime;
  uint constant contractDurationSec = 60;
  
    modifier notExpired()
    {
        require(
            contractCreationTime + contractDurationSec > now,
            "Contract has expired."
        );
        // Do not forget the "_;"! It will
        // be replaced by the actual function
        // body when the modifier is used.
        _;
    }
  
  
  event ByTokens(address fromAddr, uint value);

  
    constructor(uint initalSupply) public {
        owner = msg.sender;
        contractCreationTime = block.timestamp;
        initialTokenSupply = initalSupply;
    }
    
    function buyTokens(uint amount) public notExpired returns  (uint)  {
        require(amount<initialTokenSupply);
        initialTokenSupply-=amount;
        
        deposits[msg.sender]+=amount;
        
        // Invoke the event to log its arguments
        emit ByTokens(msg.sender,amount); 
    }
    
    
      
    function getBalance() public view returns (uint)  {
        return deposits[msg.sender];
    }

}