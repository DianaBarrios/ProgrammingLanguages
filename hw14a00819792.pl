% Diana Barrios 
% A00819792

use_module(library(bounds)).
use_module(library(clpfd)).

duplicate([],[]).
duplicate([H | TL], X) :- duplicate(TL,Y), append([H, H], Y, X).

sum([], 0).
sum([[_ | _] | TL], X) :- sum(TL, X).
sum([H | TL], X) :- sum(TL, Y), X is Y + H.

toBinaryString(0,0).
toBinaryString(1,1).
toBinaryString(N, X) :-  0 is N mod 2, M is N/2, toBinaryString(M,Y), string_concat(Y,'0',X).
toBinaryString(N, X) :-  1 is N mod 2, M is (N-1)/2, toBinaryString(M,Y), string_concat(Y,'1',X).

%findPath([[1,2,3],[2,3,7],[3,2,4],[2,4,3]],1,4,X).
%findPath([[1,2,3],[2,3,7],[3,2,4],[2,4,3]],3,4,X).
%findPath([[1,2,3],[2,3,7],[3,2,4],[2,4,3]],4,3,X).

findPath(L,A,B,Sol) :- makeEdges(L), path(A,B,Sol).

makeEdges([]).
makeEdges([[A,B,C] | T]) :- assertz(edge(A,B,C)), makeEdges(T).

path(X,Y,[[X,Y],C]) :- edge(X, Y, C).
path(X,Y,[[ X | L ], C]) :- 
    edge(X, A, W),
    path(A,Y,[L,Z]), 
    C is Z + W.

%[[4,9,2],
% [3,5,7],
% [8,1,6]]

magicSquare([[A,B,C],[D,E,F],[G,H,I]]) :- 
    L = [1,2,3,4,5,6,7,8,9],
    member(A,L),
    member(B,L),
    member(C,L),
    member(D,L),
    member(E,L),
    member(F,L),
    member(G,L),
    member(H,L),
    member(I,L), 
    15 is A + D + G, 
    15 is B + E + H, 
    15 is C + F + I, 
    15 is A + B + C, 
    15 is D + E + F,
    15 is G + H + I,
    15 is A + E + I,
    15 is C + E + G,
    all_different([A,B,C,D,E,F,G,H,I]).
       
right(X, Y, L) :-
    nth1(X1, L, X),
    nth1(Y1, L, Y),
    X1 is Y1 + 1.

next(X, Y, L) :-
    right(X, Y, L);
    right(Y, X, L) .
    
solvePuzzle(Solution) :-
    length(Solution, 5),
    member([red, _, _, _, englishman], Solution),
    member([_, dog, _, _, spanish], Solution),
    member([green, _, coffee, _, _], Solution),
    member([_, _, tea, _, ukranian], Solution),
    next([green, _, _, _, _], [white, _, _, _, _], Solution),
    member([_, serpent, _, winston, _], Solution),
    member([yellow, _, _, kool, _], Solution),
    Solution = [_, _, [_, _, milk, _, _], _, _],
    Solution = [[_, _, _, _, norwegian], _, _, _, _],
    next([_, _, _, chester, _], [_, fox, _, _, _], Solution),
    next([_, _, _, kool, _], [_, horse, _, _, _], Solution),
    member([_, _, juice, lucky, _], Solution),
    member([_, _, _, kent, japanese], Solution),
    next([_, _, _, _, norwegian], [blue, _, _, _, _], Solution),
    member([_, zebra, _, _, _], Solution),
    member([_, _, water, _, _], Solution),
    write(Solution).

%The japanese haas the zebra.
%The norwegian drinks water.
