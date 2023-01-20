//SPDX-License-Identifier: CCO

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

import 'hardhat/sonsol.sol';


contract PiggyBank is Ownable {

    // mapping to track depositors and amount
    mapping(address => uint) public depositors;
    


    uint[] public orderOfDeposits;

    address payable host;



    event Deposit(address indexed _sender, uint _amount);
    event moneyAdded(uint indexed _when, address _sender);
    event Withdraw(uint _amount);
    event Balance(uint _balance);

    constructor () payable {

        host = payable(msg.sender); // set the owner to deployer's address
        orderOfDeposits.push(msg.value);
        depositors[msg.sender] = msg.value;
    }

    // function allowing anyone to deposit ether to the contract
    function deposit() public payable {
        depositors[msg.sender] = msg.value;
        orderOfDeposits.push(msg.value); // push deposit amount to array
        emit Deposit(msg.sender, msg.value); //emit event with sender and value
        emit moneyAdded(block.timestamp, msg.sender); //emit event with time and msg.sender
    }

    // a withdraw function that withdraws all ether
    // the contract is destroyed - this piggy bank is broken
    function withdraw() external onlyOwner {
        emit Withdraw(address(this).balance); // emit this event with amount sent to owner
        selfdestruct(payable(host));
    }

    //custom errors
    error insufficientFundsError(address _caller, uint i);
    error indexOutOfRange(address _caller, uint index);

    //withdraw a partial amount
    //amount entered in wei
    function withdrawSome( address _to, uint _amount) external payable onlyOwner {
        if(_amount > address(this).balance){
            revert insufficientFundsError(msg.sender, msg.value);
        }
        payable(_to).transfer(_amount);
        emit Balance(address(this).balance);
    }

    // a function to check the balance of the contract
    function getBalance() external returns (uint) {
        emit Balance(address(this).balance);
        return address(this).balance;
    }

    //get an array of all deposits made
    function getArray()external view returns(uint[] memory){
        return orderOfDeposits;
    }

    //get the deposited value by entering an index
    function getArrayByIndex(uint _index)external view returns(uint){
        return orderOfDeposits[_index];
    }

    // a fallback function to receive ether
    receive() external payable {
        
        depositors[msg.sender] = msg.value;
        emit Deposit(msg.sender, msg.value);
    }
}

