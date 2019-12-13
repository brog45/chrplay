:- use_module(library(chr)).
:- chr_option(debug, on). 
:- chr_option(optimize, off).
:- chr_constraint thing/1, get_thing/1.
thing(N) \ get_thing(M) <=> N = M.

print_things :-
    get_thing(X),
    writeln(X),
    fail.
print_things.    

