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

add_month(date(Y,M,D), NextDate) :-
    NextMonth is M + 1,
    date_time_stamp(date(Y,NextMonth,D,0,0,0,0,-,-), TS0),
    stamp_date_time(TS0, DT0, 0),
    date_time_value(date, DT0, date(Y0,M0,D0)),
    (   D0 = D
    ->  NextDate = date(Y0,M0,D0)
    ;   date_time_stamp(date(Y0,M0,0,0,0,0,0,-,-), TS1),
        stamp_date_time(TS1, DT1, 0),
        date_time_value(date, DT1, NextDate)
    ).

print_ledger(date(Y,M,D), Description, Amount, Balance) :-
    format('~|~`0t~d~2+/~|~`0t~d~2+/~d  ~|~w~32t~40+  ~|~32t~:d~6+  ~|~32t~:d~7+~n', [M, D, Y, Description, Amount, Balance]).

:- chr_constraint balance(+), currdt(+), monthly(+,+,+), weekly(+,+,+), on(+,+,+), nextdt, untildt(+).

advance(0) :- !.
advance(Days) :- Days > 0, !, nextdt, Days1 is Days - 1, advance(Days1).

nextdt, currdt(Date) <=> 
    add_days(Date, 1, NewDate), 
    currdt(NewDate).
currdt(date(Y,M,D)) \ balance(Balance) <=> 
    Balance =< 0 
    | format('Overdrawn on ~w/~w/~w with balance ~:d~n', [M, D, Y, Balance]), 
    fail.
currdt(Date) \ balance(Balance), monthly(Date, Amount, Description) <=> 
    add_month(Date, NewDate), 
    Balance1 is Balance + Amount,
    print_ledger(Date, Description, Amount, Balance1),
    balance(Balance1),
    monthly(NewDate, Amount, Description).
currdt(Date) \ balance(Balance), weekly(Date, Amount, Description) <=> 
    add_days(Date, 7, NewDate), 
    Balance1 is Balance + Amount,
    print_ledger(Date, Description, Amount, Balance1),
    balance(Balance1),
    weekly(NewDate, Amount, Description).
currdt(Date) \ balance(Balance), on(Date, Amount, Description) <=> 
    Balance1 is Balance + Amount,
    print_ledger(Date, Description, Amount, Balance1),
    balance(Balance1).
untildt(Date1), currdt(Date2) ==> Date1 \= Date2 | nextdt.
untildt(Date), currdt(Date), balance(Balance) <=> 
    date(Y,M,D) = Date,
    format('Finishing on ~w/~w/~w with balance ~:d~n', [M, D, Y, Balance]),
    true.

go :-
    % these are made up numbers
    balance(650),
    % income
    monthly(date(2020,1,1), 1300, salary),
    monthly(date(2020,1,15), 1300, salary),
    % expenses
    weekly(date(2020,1,1), -50, groceries),
    monthly(date(2020,1,1), -350, rent),
    monthly(date(2020,1,1), -50, gas),
    monthly(date(2020,1,1), -150, electric),
    monthly(date(2020,1,28), -250, 'auto service (monthly avg)'),
    on(date(2020,2,15), -4000, tuition),
    on(date(2020,4,15), -4000, taxes),
    % start date
    currdt(date(2020,1,1)), 
    % end date
    untildt(date(2020,4,15)).
