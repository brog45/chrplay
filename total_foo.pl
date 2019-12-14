:- use_module(library(chr)).

% add and remove foo's with numeric argument, keeping running total
:- chr_constraint foo/1, total_foo/1, unfoo/1.

total_foo(A), total_foo(Total) <=> 
    NewTotal is A + Total, 
    total_foo(NewTotal).
foo(A) ==> total_foo(A).

unfoo(A), foo(A), total_foo(Total) <=> 
    NewTotal is Total - A, 
    total_foo(NewTotal).
