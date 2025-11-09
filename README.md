## Sui Bootcamp Homework Assignment

# My solution

Package deployment ID: 0x8671751ed31ae86c80a7e6befa349dcc34a8977ad73fa5a6aff578fdb1a5a51d

## Build the contract

Run `sui move build`

## Test the functions

Create a counter: `sui client ptb \ --move-call 0x8671751ed31ae86c80a7e6befa349dcc34a8977ad73fa5a6aff578fdb1a5a51d::homework::create_counter @0x6` 

@0x6 is the address of the Clock object used to get the current unix timestamp

Increment the counter: `sui client ptb \ --move-call 0x8671751ed31ae86c80a7e6befa349dcc34a8977ad73fa5a6aff578fdb1a5a51d::homework::increment <OBJECT ID>`

## Explaination

The `Counter` object has key and store abilities. So, the first field is the ID (reference to it's location in blockchain storage - address) and also the other data fields (owner, count and creation timestamp)

For the create function, we pass as argument the Clock object in order to store the creation timestamp. Also, the owner is the sender of the transaction and the count is 0 initially. We transfer the counter to the sender as he'll own it.

The increment is quite simple. The access is handled by the fact coutner is not a shared option so only the owner can pass it to the function. We pass a mutable reference, increment the count and emit the event.

The getter can be used by other modules or packages to easily read the count.