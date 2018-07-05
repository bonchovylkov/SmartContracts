pragma solidity ^0.4.24;



contract ReceivingFunds {
    
  address private owner;
  uint private currentContractValue;
  
  event AddingFunds(address fromAddr, uint value);
   event SendingMoneySelfDestruncting(address to,uint value);
  
    constructor() {
        owner = msg.sender;
    }
    
    function addFunds() public payable  {
        currentContractValue+=msg.value;
        // Invoke the event to log its arguments
        emit AddingFunds(msg.sender,msg.value); 
    }
    
      
    function getBalance() public view returns (uint)  {
        return currentContractValue;
    }

  
  
  function sendAmout(address to) {

        require(msg.sender == owner);
        emit SendingMoneySelfDestruncting(to,currentContractValue);
        //the contract destroys it's self once the transfer is done 
        selfdestruct(to);
    
    }

}