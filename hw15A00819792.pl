%Diana Barrios
%A00819792

insert(X, [], [X]) :- !.
insert(X, [H | TL], [X, H | TL]) :- X =< H.
insert(X, [H | TL], [H | Z]) :- insert(X, TL, Z).

insertionSort([], []).
insertionSort([H | TL], A) :- 
    insertionSort(TL, X),
    insert(H, X, A).

travelTime(A, B, C, Sol) :-
    A is 4,
    C is A - 1,
    B is 4 * C, 
    Sol is 2 * B,!.

before(X, Y, L) :-
    nth1(X1, L, X),
    nth1(Y1, L, Y),
    X1 < Y1.

fightCell(Solution) :-
	length(Solution, 3),
    member(vegeta, Solution),
    member(gohan, Solution),
    member(goku, Solution),
    before(gohan, vegeta, Solution),
    before(goku, gohan, Solution), !.