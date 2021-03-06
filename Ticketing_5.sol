pragma solidity ^0.4.25;

/*************************************
 * Buying a ticket now "returns" the ticket address, through the emission of an event
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
    
    event TicketAddress(address indexed _from, address TicketAddr);
        
    constructor (string name, uint eventPrice) public {
        manager = msg.sender;
        title = name;
        price = eventPrice;
    }
    
    function buyTicket() public payable {
        require(msg.value == price);
        address eventAddr = address(this);
        address newTicket = new Ticket(eventAddr, msg.sender, manager);
        purchasedTickets.push(newTicket);
        emit TicketAddress(msg.sender, newTicket); //Returns the address of the ticket
    }
    
    function getTickets() public view ManagerOnly returns (address[]) {
        return purchasedTickets;
    }
    
    function getBalance() public view ManagerOnly returns (uint){
        return address(this).balance;
    }
    
    function transferBalance() public ManagerOnly {
        manager.transfer(address(this).balance);
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
