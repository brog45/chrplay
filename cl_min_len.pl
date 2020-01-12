:- use_module(library(chr)).

:- chr_constraint cl_min_len/2.

cl_min_len(X, MinLen) <=>
    nonvar(X)
    , ground(MinLen) 
    | is_list(X)
    , number(MinLen)
    , length(X, Len)
    , Len >= MinLen.
cl_min_len(X, A) \ cl_min_len(X, B) <=> 
    A > B 
    | format('~w subsumes ~w~n', [A, B])
    , true.

:- chr_constraint cl_min_len2(?, +natural).

cl_min_len2(L, MinLen) <=>
    nonvar(L)
    | is_list(L)
    , length(L, Len)
    , Len >= MinLen.

:- chr_type list(T) ---> [] ; [T | list(T)].
:- chr_constraint cl_min_len3(?list(any), +natural).

cl_min_len3(L, MinLen) <=>
    nonvar(L)
    | length(L, Len)
    , Len >= MinLen.

/* 
?- time(findall(N, (cl_min_len(L, 5), between(1,1000,_), N is random(10), length(L,N)), Lists)).
% 117,427 inferences, 0.010 CPU in 0.010 seconds (100% CPU, 12096936 Lips)
Lists = [9, 7, 5, 7, 8, 5, 8, 5, 9|...].

?- time(findall(N, (cl_min_len2(L, 5), between(1,1000,_), N is random(10), length(L,N)), Lists)).
% 113,533 inferences, 0.015 CPU in 0.015 seconds (100% CPU, 7662798 Lips)
Lists = [7, 5, 9, 5, 7, 6, 7, 7, 9|...].

?- time(findall(N, (cl_min_len3(L, 5), between(1,1000,_), N is random(10), length(L,N)), Lists)).
% 158,427 inferences, 0.019 CPU in 0.019 seconds (100% CPU, 8232333 Lips)
Lists = [5, 5, 9, 8, 8, 5, 8, 6, 8|...].
 */
