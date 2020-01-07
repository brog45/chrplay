:- use_module(library(chr)).
:- chr_constraint must_be_int/1, must_be_int/2.

must_be_int(X) <=> ground(X) | integer(X).

must_be_int(X, _) <=> ground(X), integer(X) | true.
must_be_int(X, Context) <=> ground(X) | throw(error(type_error(integer, X), Context)).
