:- use_module(library(chr)).
:- set_prolog_flag(toplevel_mode, recursive).
:- set_prolog_flag(chr_toplevel_show_store, false).

% print out constraint store when you return to top level
ss :- set_prolog_flag(chr_toplevel_show_store, true).

% or don't
noss :- set_prolog_flag(chr_toplevel_show_store, false).

%--------------

:- chr_constraint init/0, description/2, player/1, pick_up/0, key/0, picked_up_key/0, look/0, east/0, west/0.

% clear any previous state then initialize game state
init \ key <=> true.
init \ player(_) <=> true.
init \ description(_,_) <=> true.
init <=> description(bedroom, 'An ordinary bedroom. The bed is not made.'),
         description(living_room, 'Bob\'s living room. The picture matches his sofa. There is a key here.'),
         description(library, 'Bob\'s library. Mostly Harlequin romances and Readers Digest.'),
         player(bedroom).

% moves
player(bedroom), east <=> player(living_room).
player(living_room), east, key <=> player(library).
player(library), west <=> player(living_room).
player(living_room), west <=> player(bedroom).
player(living_room), key \ pick_up <=> writeln('You already have the key.').
player(living_room) \ pick_up <=> key, picked_up_key.
east <=> writeln('You can\'t go east here.').
west <=> writeln('You can\'t go west here.').
pick_up <=> writeln('Nothing to pick up here.').

% printing

% make the living_room description change when the key's picked up
% picked_up_key prevents an infinite loop
key \ picked_up_key, description(living_room, _) <=> description(living_room, 'Bob\'s living room. The picture matches his sofa.').

% print the player's location
player(Loc), description(Loc, Desc) ==> writeln(Desc).

% handle look command

look, player(Loc), description(Loc, Desc) ==> writeln(Desc).
look, key ==> writeln('You are carrying a key.').
look <=> true.
