:- use_module(library(chr)).

:- chr_constraint bits_on/2, bits_off/2.

bits_on(Bits, X) <=> ground(Bits), ground(X) | Bits is X /\ Bits.
bits_off(Bits, X) <=> ground(Bits), ground(X) | Bits is X \/ Bits.

