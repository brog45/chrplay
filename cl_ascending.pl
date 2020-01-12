:- use_module(library(chr)).

% % ?- time((cl_ascending(_L), length(_L,5), _L ins 1..5, forall(label(_L), true))).
% % 589,874 inferences, 0.054 CPU in 0.054 seconds (100% CPU, 10837748 Lips)
% :- chr_type list(T) ---> [] ; [T | list(T)].
% :- chr_constraint cl_ascending(?list(number)).

% ?- time((cl_ascending(_L), length(_L,5), _L ins 1..5, forall(label(_L), true))).
% % 489,676 inferences, 0.047 CPU in 0.047 seconds (100% CPU, 10368655 Lips)
% :- chr_type list ---> [] ; [any | list].
% :- chr_constraint cl_ascending(?list).

% % ?- time((cl_ascending(_L), length(_L,5), _L ins 1..5, forall(label(_L), true))).
% % % 432,937 inferences, 0.038 CPU in 0.038 seconds (100% CPU, 11302930 Lips)
% :- chr_constraint cl_ascending(?).

% ?- time((cl_ascending(_L), length(_L,5), _L ins 1..5, forall(label(_L), true))).
% % 432,937 inferences, 0.037 CPU in 0.038 seconds (98% CPU, 11643740 Lips)
:- chr_constraint cl_ascending/1.

cl_ascending(L) <=> ground(L) 
    | L = []
    ; L = [_]
    ; L = [A,B|Tail], B >= A, cl_ascending([B|Tail]).
