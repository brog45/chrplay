:- use_module(library(chr)).

:- chr_constraint bits_on(+,?), bits_off(+,?).

bits_on(Bits, X) <=> ground(X) | Bits is X /\ Bits.
bits_off(Bits, X) <=> ground(X) | Bits is X \/ Bits.

