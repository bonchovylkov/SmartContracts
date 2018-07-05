pragma solidity ^0.4.24;



contract ReceivingFunds {
    
  address internal owner;
  uint internal currentContractValue;
  
  event AddingFunds(address fromAddr, uint value);
  
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

}

contract ContractTerminate is ReceivingFunds {
    
      event SendingMoneySelfDestruncting(address to,uint value);
    
    function sendAmout(address to) {

        require(msg.sender == ReceivingFunds.owner);
        emit SendingMoneySelfDestruncting(to,ReceivingFunds.currentContractValue);
        //the contract destroys it's self once the transfer is done 
        selfdestruct(to);
    
    }

}