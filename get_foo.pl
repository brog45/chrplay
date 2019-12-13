:- use_module(library(chr)).

:- chr_constraint foo/1,one_foo/1, collect_foo/1, get_foo/1.

load_it :-
    foo(1),
    foo(3),
    foo(7).

% copy constraints to be collected
foo(X), get_foo(_) ==> one_foo(X).
get_foo(L) <=> collect_foo(L).

% collect and remove copied constraints
one_foo(X), collect_foo(L) <=>
          L=[X|L1], collect_foo(L1).
collect_foo(L) <=> L=[].

go(X) :-
    %load_it,
    get_foo(X).

