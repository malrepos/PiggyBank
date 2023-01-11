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

The deposit function updates the depositors mapping and emits an event that will log the address and the amount of the depositor. It also emits an even that will log the timestamp and amount of the deposit.

The withdraw function uses an onlyOwner modifier to ensure that only the owner can call it. We first emit an event and then destroy the contract, sending the balance of the contract to the owner.

The withdrawSome(0 function allows the user to withdraw a pecified amount from the contract. It does not destroy the contract. An event is emitted.)

A getBalance function simply returns the balance of the contract. An event is emmitted logging the balance.

There is a fallback function (receive) that will also emit an event detailing the deposit details and update teh depositors mapping.

The mapping is public so we have a getter function for it. By entering an address we can see how much eth that adddress has deposited into the contract.

---

On the second iteration I added a withdrawSome function that allows the owner to withdraw some amount from the piggy bank. I would like to eventually make this function optional when the contract is deployed, thereby allowing the user to choose the kind of piggy bank they want.

Deployment

The contract was deployed to the Goerli testnet:

https://goerli.etherscan.io/tx/0x6cd9d5af48e5f93d8df411be8cb5c1d66da72550bac53b8cd4c40279decbeb68

And here is the deployed contract on etherescan:

https://goerli.etherscan.io/address/0x577e8b6c178295ae3a6f08d100f5c894a926906d

![Goerli Contract Address QR code](images/Goerli_QR.png)
