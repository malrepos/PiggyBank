# PiggyBank

A piggy bank for digital currency.

A piggy bank is an easy application to write that has some usefulness in the new digital space. I had a piggy bank as a kid that I put money into fairly regularly, and I can imagine a similar activity for kids today using digital currency. It also applies basic principles that can be used in a regular savings account, group investment project. These will be good follow on projects.

## Process

There are a few decisions that need to be made about the functionality of our piggy bank before we build it: - can anyone deposit ether into our piggy bank, or only the owner? - can the owner withdraw partial amounts from the piggy bank? Or, is it one of those piggies that need to be broken in order to get the money out?

I decided to allow anyone to deposit ether into the piggy bank, thereby making it more of a kid friendly dapp.

I aslo made this an old school piggy bank with no hole on the bottom to take amounts out. To withdraw from this bank you have to destroy the pig.

### State Variables

I want to track who has deposited eth into the account and how much, so I added a mapping to do this:

```
    mapping(address => uint)public depositors;
```

Two events will be emitted, one when someone deposits ether, and one when ether is withdrawn:

```
    event Deposit(address _sender, uint _amount);
    event Withdraw(uint _amount);
```

### Functions

The deposit function updates the depositors mapping and emits an event that will log the address and the amount of the depositor.

The withdraw function uses an onlyOwner modifier to ensure that only the owner can call it. We first emit an event and then destroy the contract, sending the balance of the contract to the owner.

A getBalnce function simply returns the balance of the contract. An event is emmitted logging the balance.

There is a fallback function (receive) that will also emit an event detailing the deposit details and update teh depositors mapping.
