:- use_module(library(chr)).

% :- chr_constraint cl_ascending/1.

:- chr_type list(T) ---> [] ; [T | list(T)].
:- chr_constraint cl_ascending(?list(number)).

cl_ascending(L) <=> ground(L) 
    | L = []
    ; L = [_]
    ; L = [A,B|Tail], B >= A, cl_ascending([B|Tail]).
