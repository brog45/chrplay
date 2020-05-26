:- use_module(bills).

go :-
    % these are made up numbers
    balance(650),
    % income
    every(month, date(2020,1,1), 1300, salary),
    every(month, date(2020,1,15), 1300, salary),
    % expenses
    every(week, date(2020,1,1), -50, groceries),
    every(month, date(2020,1,1), -350, rent),
    every(month, date(2020,1,1), -50, gas),
    every(month, date(2020,1,1), -150, electric),
    every(month, date(2020,1,28), -250, 'auto service (monthly avg)'),
    on(date(2020,2,15), -4000, tuition),
    on(date(2020,4,15), -800, taxes),
    % start date
    currdt(date(2020,1,1)), 
    % end date
    untildt(date(2020,4,15)).
