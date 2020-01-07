:- use_module(library(chr)).

:- chr_constraint at_voltage/2, short/1, wire/2.

% remove duplicates
short(T) \ short(T) <=> true.
% prevent an infinite loop
at_voltage(V, T) \ at_voltage(V, T) <=> true.
% if we are holding a pin at two different voltages there's a short
at_voltage(V1, T), at_voltage(V2, T) ==> V1 \= V2 | short(T).
% connections to a pin from a voltage source hold that pin at the source
% vcc is the power supply voltage, gnd is ground
wire(Term, vcc) ==> at_voltage(vcc, Term).
wire(Term, gnd) ==> at_voltage(gnd, Term).
wire(vcc, Term) ==> at_voltage(vcc, Term).
wire(gnd, Term) ==> at_voltage(gnd, Term).
% if T1 and T2 have a wire between them and one end is held at a voltage,
% the other end is too
wire(T1, T2), at_voltage(V, T1) ==> at_voltage(V, T2).
wire(T1, T2), at_voltage(V, T2) ==> at_voltage(V, T1).
