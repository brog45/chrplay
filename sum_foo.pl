:- use_module(library(chr)).

:- chr_constraint foo/1, one_foo/1, sum_foo/1, do_sum_foo/0.

load_it :-
    foo(1),
    foo(3),
    foo(7).

% copy constraints to be collected
foo(X), do_sum_foo ==> one_foo(X).
do_sum_foo <=> sum_foo(0).

% collect and remove copied constraints
one_foo(X), sum_foo(N) <=>
    NN is N + X,
    sum_foo(NN).

go(X) :- 
    load_it, 
    do_sum_foo, 
    find_chr_constraint(sum_foo(X)).
