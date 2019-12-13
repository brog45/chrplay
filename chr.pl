:- use_module(library(chr)).

:- chr_constraint 
      salt/0
    , water/0
    , stir/0
    , noise/0
    , salt_water/0
    , time/0
    , more_than_3/1
    .

water \ water <=> true.
salt \ salt <=> true.
salt_water \ water <=> true.
stir ==> noise.
stir \ salt, salt_water <=> salt_water.
stir \ salt, water <=> salt_water.
stir <=> true.
time \ salt_water <=> salt.
time \ water <=> true.
time <=> true.

:- chr_constraint interval/2.

interval(X, Y) <=> X > Y | interval(Y, X).
% interval(X, Y) \ interval(A, B) <=> between(X, Y, A), between(X, Y, B) | true.
% interval(X, Y), interval(A, B) <=> between(A, B, X), between(X, Y, B) | interval(A, Y).
interval(X, Y), interval(A, B) <=> between(X, Y, A) | Z is max(Y, B), interval(X, Z).

:- chr_constraint moo/0,bar/0.
moo ==> bar.

:- chr_constraint backtrack/1.
backtrack(X) ==> member(X, [a,b,c]).

:- chr_constraint lucky/1.
lucky(Number) <=> atom_chars(Number, Digits), \+ maplist(=('8'), Digits) | true.

:- chr_constraint thing/1, get_thing/1.
thing(N) \ get_thing(M) <=> N = M.

print_things :-
    repeat,
    get_thing(X),
    writeln(X),
    fail.
print_things.    

