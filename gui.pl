:- use_module(library(chr)).
:- set_prolog_flag(toplevel_mode, recursive).

do_action(_).

% adds tick to the store every 0.2 seconds for 2 frames
start_animation(_,_).

%--------------

:- chr_constraint button/1, appearance/2, mousedown/1, mouseentered/1, mouseleft/1, mouseup/0, pending_button/1, tick/0.

% came down over B
button(B) \ appearance(B, up), mousedown(B) <=> appearance(B, active).
% mouse is down and user moved off the button
button(B) \ appearance(B, active), mouseleft(B) <=> appearance(B, up), pending_button(B).
% came back on - we stored pending_button above so we only activate the original down button
button(B) \ appearance(B, up), mouseentered(B), pending_button(B) <=> appearance(B, active).
% mouseup with the mouse over the button
% dispatch the action and start an animation. the start_animation prolog predicate adds
% tick to the store every 0.2 seconds for 2 frames
button(B) \ appearance(B, active), mouseup <=> do_action(B), appearance(B, click0), start_animation(2, 0.2).
% mouseup with the mouse not over button
button(B) \ pending_button(B), mouseup <=> true.
% handle the animation
appearance(B, click0), tick <=> appearance(B, click1).
appearance(B, click1), tick <=> appearance(B, up).
