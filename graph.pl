:- use_module(library(chr)).
% make all connected edges
% if you have a-b b-c c-d
% add a-c b-d a-d

:- chr_constraint node/2.
node(A,B) \ node(A,B) <=> true. % anti-cycle
node(A,B), node(B,C) ==> node(A,C).

% ?- node(1,2), node(2,3), node(3,1).
% query(5, 2, X).

% :- chr_constraint query/3.
:- chr_constraint query(+, +, -). % uses material from advanced chapter
node(A,D), node(B,E) \ query(A,B,C) <=> C is E + D.
