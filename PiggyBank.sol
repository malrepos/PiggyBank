//SPDX-License-Identifier: CCO

pragma solidity ^0.8.0;

contract PiggyBank {
    // mapping to track depositors and amount
    mapping(address => uint) public depositors;
    //mapping to track the time a deposit is made and by whom
    mapping(uint => address) public timeDeposited;

// this is an expanded mapping consolidating the 2 previous mappings
// an address maps to a timestamp which maps to an amount
// for each address we can see when a deposit is made and the amount
    mapping(address => mapping(uint => uint)) expandedDepositors;

    address payable owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner.");
        _;
    }

    event Deposit(address indexed _sender, uint _amount);
    event moneyAdded(uint indexed _when, address _sender);
    event Withdraw(uint _amount);
    event Balance(uint _balance);

    constructor() {
        owner = payable(msg.sender); // set the owner to deployer's address
    }

    // function allowing anyone to deposit ether to the contract
    function deposit() public payable {
        //payable(address(this)).transfer(msg.value);
        depositors[msg.sender] = msg.value;
        timeDeposited[block.timestamp] = msg.sender; // track when a deposit is made, and by whom
        emit Deposit(msg.sender, msg.value); //emit event with sender and value
        emit moneyAdded(block.timestamp, msg.sender); //emit event with time and msg.sender
    }

    // a withdraw function that withdraws all ether
    // the contract is destroyed - this piggy bank is broken
    function withdraw() external onlyOwner {
        emit Withdraw(address(this).balance); // emit this event with amount sent to owner
        selfdestruct(payable(owner));
    }

    function withdrawSome(uint _amount) external onlyOwner {
        require(_amount >= address(this).balance, "Not enough funds");
        payable(address(this)).transfer(_amount);
        emit Balance(address(this).balance);
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
