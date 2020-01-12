:- use_module(library(chr)).
% :- set_prolog_flag(toplevel_mode, recursive).

% :- chr_constraint design_check/0, wire/2, pin_not_checked/1.
:- chr_constraint design_check/0, wire(+,+), pin_not_checked(+).

%--------------

design_check, wire(T, _) ==> pin_not_checked(T).
design_check, pin_not_checked(T) \ pin_not_checked(T) <=> true. % get rid of duplicates
design_check, wire(T, A), wire(T, B) \ pin_not_checked(T) <=> A \= B | true.
design_check, pin_not_checked(T) <=> format('Pin ~q fails', [T]), fail.
design_check <=> true.
