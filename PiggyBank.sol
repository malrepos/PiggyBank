//SPDX-License-Identifier: CCO

pragma solidity ^0.8.0;

contract PiggyBank {
    // mapping to track depositors and amount
    mapping(address => uint) public depositors;

    address payable owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

    event Deposit(address _sender, uint _amount);
    event Withdraw(uint _amount);
    event Balance(uint _balance);

    constructor() {
        owner = payable(msg.sender); // set the owner to deployer's address
    }

    // function allowing anyone to deposit ether to the contract
    function deposit() public payable {
        //payable(address(this)).transfer(msg.value);
        depositors[msg.sender] = msg.value;
        emit Deposit(msg.sender, msg.value); //emit event with sender and value
    }

    // a withdraw function that withdraws all ether
    // the contract is destroyed - this piggy bank broken
    function withdraw() external onlyOwner {
        emit Withdraw(address(this).balance); // emit this event with amount sent to owner
        selfdestruct(payable(owner));
    }

    // a function to check the balance of the contract
    function getBalance() external returns (uint) {
        emit Balance(address(this).balance);
        return address(this).balance;
    }

    // a fallback function to receive ether
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
        depositors[msg.sender] = msg.value;
    }
}
