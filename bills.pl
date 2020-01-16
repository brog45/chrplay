:- use_module(library(chr)).

get_date(Date) :-
    get_time(Timestamp), 
    stamp_date_time(Timestamp, DateTime, local), 
    date_time_value(date, DateTime, Date).

add_days(date(Y,M,D), Days, date(Y2,M2,D2)) :-
    D1 is D + Days,
    date_time_stamp(date(Y,M,D1,0,0,0,0,-,-), TS),
    stamp_date_time(TS, DT, 0),
    date_time_value(date, DT, date(Y2,M2,D2)).

:- chr_constraint balance(+), currdt(+), weekly(+,+,+), nextdt, untildt(+).

advance(0) :- !.
advance(Days) :- Days > 0, !, nextdt, Days1 is Days - 1, advance(Days1).

nextdt, currdt(Date) <=> 
    add_days(Date, 1, NewDate), 
    currdt(NewDate).
currdt(Date) \ balance(Balance) <=> 
    Balance =< 0 
    | format('Date: ~w  Balance: ~w~n', [Date, Balance]), 
    fail.
currdt(Date) \ balance(Balance), weekly(Date, Amount, Description) <=> 
    add_days(Date, 7, NewDate), 
    Balance1 is Balance - Amount,
    balance(Balance1),
    weekly(NewDate, Amount, Description).
untildt(Date1), currdt(Date2) ==> Date1 \= Date2 | nextdt.
untildt(Date), currdt(Date) <=> true.
