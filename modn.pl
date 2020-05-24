:- use_module(library(chr)).

next_day(date(Y,M,D), date(Y2,M2,D2)) :-
    D1 is D + 1,
    date_time_stamp(date(Y,M,D1,0,0,0,0,-,-), TS),
    stamp_date_time(TS, DT, 0),
    date_time_value(date, DT, date(Y2,M2,D2)).

:- chr_constraint today/1, nextday, day_of_month/1.

advance(0) :- !.
advance(Days) :- Days > 0, !, nextday, Days1 is Days - 1, advance(Days1).

today(date(Y,M,D)), day_of_month(D) ==> writeln(Y-M-D).
today(D1), nextday <=> next_day(D1, D2), today(D2).
