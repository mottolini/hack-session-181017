pragma solidity ^0.4.25;

/****************************
 * Anybody can buy a ticket (without paying)
 * Tickets sold are kept in the Event
 * Anybody could retrieve the list of tickets
 */
 
contract Event {
    address public manager; //Owner of the Event
    string title;
    uint public price;
    address[] private purchasedTickets;

    constructor (string name, uint eventPrice) public {
        manager = msg.sender;
        title = name;
        price = eventPrice;
    }
    
    function buyTicket() public {
        address eventAddr = address(this);
        address newTicket = new Ticket(eventAddr, msg.sender, manager);
        purchasedTickets.push(newTicket);
    }
    
    function getTickets() public view returns (address[]) {
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
