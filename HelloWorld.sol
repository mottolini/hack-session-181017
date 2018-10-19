pragma solidity ^0.4.25;

contract Hello {
    string hello;
    
    constructor () public {
        hello = "Hello World!";  
    }
    
    function getHello() public view returns (string){
        return hello;
    }
    
}
