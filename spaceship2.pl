:- use_module(library(chr)).
:- set_prolog_flag(toplevel_mode, recursive).

%--------------

:- chr_constraint ship/1, health/2, health_state/2, hit/2, appearance/2.

% ships start out ok state with 20 hit points
ship(S) ==> health_state(S, ok), health(S, 20).

% ignore hits on dead ships
ship(S), health_state(S, dead) \ hit(S, _) <=> true.

% take damage
ship(S) \ health(S, H), hit(S, Damage) <=>
                NH is H - Damage,
                health(S, NH).

% die if ship falls below 0 health
ship(S), health(S, H) \ health_state(S, State) <=>
         H =< 0, State \= dead |
         health_state(S, dead).

% for now appearance is just state
ship(S), health_state(S, State) ==> appearance(S, State).
appearance(S, dead) \ appearance(S, _) <=> true.
