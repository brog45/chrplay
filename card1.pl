:- use_module(library(chr)).

:- chr_constraint card/1, straight/0.

card(A), card(B), card(C), card(D), card(E) ==>
         succ(A,B),
         succ(B,C),
         succ(C,D),
         succ(D,E) | straight.

/*
?- time(card(2)),card(4),card(3),card(5),time(card(6)).
% 53 inferences, 0.000 CPU in 0.000 seconds (91% CPU, 906587 Lips)
% 9,732 inferences, 0.003 CPU in 0.003 seconds (100% CPU, 3520335 Lips)
 */
