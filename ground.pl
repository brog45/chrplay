:- use_module(library(chr)).

:- chr_constraint more_than_3/1.

more_than_3(N) <=> ground(N) | N > 3.

%more_than_3(N) <=> ground(N), N > 3 | true.
%more_than_3(N) <=> ground(N) | fail.

%more_than_3(N) <=> ground(N), N > 3 | writeln('more').
%more_than_3(N) <=> ground(N) | writeln('not more'), fail.

% vim: et sw=4 ts=4
