:- use_module(library(chr)).
:- set_prolog_flag(toplevel_mode, recursive).

%--------------

:- chr_constraint ship/1, dead/1, hit/2, health/2, appearance/2.

% ignore hits on dead ships
ship(S), dead(S) \ hit(S, _) <=> true.
% die if ship falls below 0 health
ship(S) \ health(S, H), hit(S, Damage), appearance(S, _) <=>
                H - Damage > 0 |
                appearance(S, damaged),
                NH is H - Damage,
                health(S, NH).
ship(S) \ health(S, H), hit(S, Damage) <=>
                H - Damage =< 0 |
                dead(S).
ship(S), dead(S) \ appearance(S, A) <=>
                A \= dead |
                appearance(S, dead).
