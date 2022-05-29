pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;//dynamic array;reference type
    
    function Lottery() public {//constructor
        manager = msg.sender;
    }
    //enter addresses of players when they pay at least 0.01ether
    function enter() public payable { 
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
    //generates random number
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
    }
    //pick winner by using modulo % that gets values of range{0--players.length-1}
    function pickWinner() public restricted {   //balance---is the ether that the contract has
        uint index = random() % players.length;
        players[index].transfer(this.balance); //players[index] is an address{{addresses are objects that have functions eg.transfer}}
        players = new address[](0);             
    }
    
    modifier restricted() {
        require(msg.sender == manager);   ////function modifier-- {lecture 82}
        _;
    }
    ///{lecture 83} return player array
    function getPlayers() public view returns (address[]) {
        return players;
    }
}   