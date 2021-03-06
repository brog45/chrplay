:- module(bills,[on/3,every/4,balance/1,untildt/1,currdt/1]).

:- use_module(library(chr)).

add_days(date(Y,M,D), Days, date(Y2,M2,D2)) :-
    D1 is D + Days,
    date_time_stamp(date(Y,M,D1,0,0,0,0,-,-), TS),
    stamp_date_time(TS, DT, 0),
    date_time_value(date, DT, date(Y2,M2,D2)).

add_months(date(Y,M,D), Months, NextDate) :-
    NextMonth is M + Months,
    date_time_stamp(date(Y,NextMonth,D,0,0,0,0,-,-), TS0),
    stamp_date_time(TS0, DT0, 0),
    date_time_value(date, DT0, date(Y0,M0,D0)),
    % When the next month is shorter than current mnth, we get back the original month plus two and the day no longer matches. 
    % When that happens we use day 0 to calculate the last day of the previous month.
    (   D0 = D
    ->  NextDate = date(Y0,M0,D0)
    ;   date_time_stamp(date(Y0,M0,0,0,0,0,0,-,-), TS1),
        stamp_date_time(TS1, DT1, 0),
        date_time_value(date, DT1, NextDate)
    ).

% date_next(+,+,-)
date_next(_, Date, _) :- \+ ground(Date), !, fail.
date_next(_, _, NextDate) :- ground(NextDate), !, fail.
date_next(day, Date, NextDate) :- add_days(Date, 1, NextDate).
date_next(week, Date, NextDate) :- add_days(Date, 7, NextDate).
date_next(month, Date, NextDate) :- add_months(Date, 1, NextDate).
date_next(quarter, Date, NextDate) :- add_months(Date, 3, NextDate).
date_next(year, date(Y,2,29), date(NextYear,2,28)) :- !, succ(Y, NextYear). % leap year
date_next(year, date(Y,M,D), date(NextYear,M,D)) :- succ(Y, NextYear).

print_ledger(date(Y,M,D), Description, Amount, Balance) :-
    format('~|~`0t~d~2+/~|~`0t~d~2+/~d  ~|~w ~`.t~42+ ~|~32t~:d~6+  ~|~32t~:d~7+~n', 
        [M, D, Y, Description, Amount, Balance]).

:- chr_type interval ---> day ; week ; month; quarter; year.
:- chr_type date ---> date(int,int,int).
:- chr_constraint balance(+int), currdt(+date), every(+interval,+date,+int,+), on(+date,+int,+), nextdt, untildt(+date), overdrawn(+date,+int).

nextdt, currdt(Date) <=> 
    date_next(day, Date, NewDate), 
    currdt(NewDate).

currdt(Date), balance(Balance) ==> Balance =< 0 | overdrawn(Date, Balance).

overdrawn(Date, Balance1), overdrawn(Date, Balance2) <=> 
    Balance is min(Balance1, Balance2), 
    overdrawn(Date, Balance).

% skip past transactions
currdt(Date1) \ every(Interval, Date, Amount, Description) <=> 
    Date1 @> Date 
    | date_next(Interval, Date, NewDate), 
    every(Interval, NewDate, Amount, Description).

currdt(Date) \ balance(Balance), every(Interval, Date, Amount, Description) <=> 
    date_next(Interval, Date, NewDate), 
    Balance1 is Balance + Amount,
    print_ledger(Date, Description, Amount, Balance1),
    balance(Balance1),
    every(Interval, NewDate, Amount, Description).

currdt(Date) \ balance(Balance), on(Date, Amount, Description) <=> 
    Balance1 is Balance + Amount,
    print_ledger(Date, Description, Amount, Balance1),
    balance(Balance1).

untildt(Date1), currdt(Date2) ==> Date1 \= Date2 | nextdt.

untildt(UntilDate), currdt(UntilDate) \ overdrawn(Date, Balance) <=>
    % print overdrawn days
    date(Y,M,D) = Date,
    format('Overdrawn on ~w/~w/~w with balance ~:d~n', [M, D, Y, Balance]).

untildt(Date), currdt(Date) \ balance(Balance) <=> 
    % print final balance
    date(Y,M,D) = Date,
    format('Finishing on ~w/~w/~w with balance ~:d~n', [M, D, Y, Balance]).
