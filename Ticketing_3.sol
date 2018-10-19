pragma solidity ^0.4.25;

/*************************************
 * Only the manager is allowed to retrieve the list
 */
 
contract Event {
    address public manager; //Owner of the Event
    string title;
    uint price;
    address[] private purchasedTickets;

    modifier ManagerOnly() {
        require(manager == msg.sender);
        _;
    }
        
    constructor (string name, uint eventPrice) public {
        manager = msg.sender;
        title = name;
        price = eventPrice;
    }
    
    function buyTicket() public  {
        address eventAddr = address(this);
        address newTicket = new Ticket(eventAddr, msg.sender, manager);
        purchasedTickets.push(newTicket);
    }
    
    function getTickets() public view ManagerOnly returns (address[]) {
        return purchasedTickets;
    }

}

contract Ticket {
    address public owner;
    address public manager;
    address public eventAddress;
    
    constructor (address _eventAddr, address _buyer, address _manager) public {
        owner = _buyer;
        manager = _manager;
        eventAddress = _eventAddr;
    }
}
