// sui move new tip_jar

module tip_jar::tip_jar;

use sui::coin::Coin;
use sui::sui::SUI;

public struct TipJar has key {
    id: UID,
    amount: u64,
    no_of_tips: u64,
    owner: address,
}

fun init(ctx: &mut TxContext) {
    let tip_jar = TipJar {
        id: object::new(ctx),
        amount: 0,
        no_of_tips: 0,
        owner: ctx.sender(),
    };

    sui::transfer::share_object(tip_jar);
}

public fun tip(tip_jar: &mut TipJar, payment: Coin<SUI>) {
    tip_jar.no_of_tips = tip_jar.no_of_tips + 1;
    tip_jar.amount = tip_jar.amount + payment.balance().value();

    sui::transfer::public_transfer(payment, tip_jar.owner);
}

