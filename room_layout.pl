:- use_module(library(chr)).
:- set_prolog_flag(toplevel_mode, recursive).

%--------------

% Specifying modes speeds up this example.
:- chr_constraint place(+, +).

% % Adding types actually slows it down, though.
% :- chr_type furniture ---> sofa ; desk ; tv.
% :- chr_type wall ---> n ; s ; e ; w.
% :- chr_constraint place(+furniture, +wall).

find_placement :-
    member(Sofa, [n, s, e, w]),
    place(sofa, Sofa),
    member(TV, [n, s, e, w]),
    place(tv, TV),
    member(Desk, [n, s, e, w]),
    place(desk, Desk),
    format('place sofa on ~w, tv on ~w, desk on ~w~n', [Sofa, TV, Desk]).

place(sofa, n) ==> fail.  % door to kitchen doesn't leave enough space for sofa
place(sofa, s) ==> fail.  % outside door and puja niche don't leave enough space for sofa
place(sofa, X), place(tv, Y) ==> opposite(X,Y).  % demand sofa and tv are on opposite walls
place(desk, n) <=> fail.  % don't place the desk on the north wall, no room.

opposite(n, s).
opposite(s, n).
opposite(e, w).
opposite(w, e).
