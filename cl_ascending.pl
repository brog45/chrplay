:- use_module(library(chr)).

:- chr_constraint cl_ascending/1.

cl_ascending(L) <=> ground(L) 
    | L = []
    ; L = [_]
    ; L = [A,B|Tail], B >= A, NewList = [B|Tail], cl_ascending(NewList).
