:- use_module(library(chr)).

:- chr_constraint cl_list/1.

cl_list(X) <=> nonvar(X) | is_list(X).

go :- cl_list(X),
      writeln('x not bound'),
      X=[_].

gofail :- cl_list(X),
          writeln('x not bound'),
          X=3.

