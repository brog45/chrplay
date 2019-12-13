:- use_module(library(chr)).
:- chr_option(debug, on). 
:- chr_option(optimize, off).

:- chr_constraint init/1,num/1.
% primes

% generate numbers from 1-n
init(_) ==> num(1).
init(N), num(M) ==> N > M | succ(M, NewM), num(NewM).
num(N) \ init(N) <=> true.

% remove the non-primes.
num(A) \ num(B) <=> B > A, A > 1, B mod A =:= 0 | true.
