:- use_module(moduleb).
:- use_module(library(chr)).
:- chr_constraint in_a/0.

in_a ==> in_b.

:- chr_constraint call_private/0.

call_private ==> moduleb:private_b.
