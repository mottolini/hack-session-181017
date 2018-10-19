pragma solidity ^0.4.25;

/****************************
 * We simply create the event.
 * The creator is the manager
 */
 
contract Event {
    address public manager; //Owner of the Event
    string title;
    uint price;

    constructor (string name, uint eventPrice) public {
        manager = msg.sender;
        title = name;
        price = eventPrice;
    }

}
