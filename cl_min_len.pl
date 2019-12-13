:- use_module(library(chr)).

:- chr_constraint cl_min_len/2.

cl_min_len(X, MinLen) <=>
         nonvar(X),
         ground(MinLen) |
         is_list(X),
         number(MinLen),
         length(X, Len),
         Len >= MinLen.
cl_min_len(X, A) \ cl_min_len(X, B) <=> 
    A > B 
    | format('~w subsumes ~w~n', [A, B])
    , true.
