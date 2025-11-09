module homework::homework;

use sui::clock::Clock;
use sui::event;

public struct Counter has key, store {
    id: UID,
    owner: address,
    count: u64,
    creation_timestamp: u64
}

public struct CounterCreatedEvent has copy, drop {
    id: ID,
    owner: address,
    creation_timestamp: u64,
}

public fun create_counter(clock: &Clock, ctx: &mut TxContext) {
    let counter = Counter {
        id: object::new(ctx),
        owner: ctx.sender(),
        count: 0,
        creation_timestamp: clock.timestamp_ms()
    };

    event::emit(CounterCreatedEvent {
        id: object::id(&counter),
        owner: counter.owner,
        creation_timestamp: counter.creation_timestamp
    });

    transfer::public_transfer(counter, ctx.sender())
}

public struct CounterIncrementedEvent has copy, drop {
    id: ID,
    count: u64
}

public fun increment(counter: &mut Counter) {
    counter.count = counter.count + 1;

    event::emit(CounterIncrementedEvent {
        id: object::id(counter),
        count: counter.count
    });
}

public fun get_value(counter: &Counter): u64 {
    counter.count
}



