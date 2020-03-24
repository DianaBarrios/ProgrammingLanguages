/*
Diana Barrios 
A00819792
*/

square([], []).
square([H | TL], [Y | Z]) :- Y is H^2, square(TL, Z).
    
sum(1, 1).
sum(N, X) :- M is N - 1, sum(M, Y), X is N + Y.

xLength([], 0).
xLength([_], 1).
xLength([_ | TL], X) :- xLength(TL, Y), X is Y + 1.

nLength([], 0).
nLength([[_ | T] | TL], X) :- nLength(T, Z), nLength(TL, Y), X is Y + Z + 1, !.
nLength([_ | T], X) :- nLength(T, Y), X is Y + 1, !.

dotProduct([X], [Y], Z) :- Z is X * Y.
dotProduct([H | T], [HX | TX], X) :- Y is H * HX, dotProduct(T, TX, Z), X is Y + Z.