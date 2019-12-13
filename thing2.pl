:- use_module(library(chr)).

:- chr_constraint thing/1, print_things/0.

thing(X), print_things ==> writeln(X).
print_things <=> true.

:- chr_constraint one_thing/1, collect_things/1, get_things/1.

% copy constraints to be collected
thing(X), get_things(_) ==> one_thing(X).
get_things(L) <=> collect_things(L).

% collect and remove copied constraints
one_thing(X), collect_things(L) <=>
          L=[X|L1], collect_things(L1).
collect_things(L) <=> L=[].

get_thing(T) :-
    get_things(Ts),
    member(T, Ts).

load_things :-
    thing(apple),
    thing(banana).

go :-
    load_things,
    print_things.

