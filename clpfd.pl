:- use_module(library(clpfd)).

foo(X) :- X in 1..3.
foo(X) :- X in 5..7.
foo(X) :- X in 8..12.
