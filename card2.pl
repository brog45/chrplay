:- use_module(library(chr)).

:- chr_constraint adj_pair/2, adj_triple/2.
:- chr_constraint card/1, straight/0.

card(A), card(B) ==> succ(A,B) | adj_pair(A,B).
adj_pair(A,B),card(C) ==> succ(B,C) | adj_triple(A, C).
adj_pair(_,B),adj_triple(C,_) <=> succ(B,C) | straight.
adj_triple(_,B),adj_pair(C,_) <=> succ(B,C) | straight.

/*
?- time(card(2)),card(4),card(3),card(5),time(card(6)).
% 33 inferences, 0.000 CPU in 0.000 seconds (95% CPU, 1126203 Lips)
% 658 inferences, 0.000 CPU in 0.000 seconds (100% CPU, 4091734 Lips)
 */
