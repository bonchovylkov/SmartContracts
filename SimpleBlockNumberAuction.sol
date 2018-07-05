

pragma solidity ^0.4.24;



contract SimpleBlockNumberAuction {
    
  address private owner;
  uint private initialTokenSupply;
  mapping(address=> uint) private deposits;
  uint  private contractBlockNumber;

  
    modifier notExpired()
    {
        require(
            contractBlockNumber + 1 >= block.number,
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
        contractBlockNumber = block.number;
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