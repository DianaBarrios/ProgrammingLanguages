
:- use_module(library(clpfd)).

enigmaA(X, X, [X]).
enigmaA(X, Y, [Y|L]) :- X =< Y, Z is Y - 1, enigmaA(X, Z, L), !.

enigmaB([], _, []).
enigmaB(_, [], []).
enigmaB([X | Xs], [Y | Ys], [[X, Y, Z] | W]):- Z is X + Y,
enigmaB(Xs, Ys, W), !.

before(X,Y,L) :-
    nth1(X1, L, X), 
    nth1(Y1, L, Y),
    X1 < Y1.

justRight(X,Y,L) :-
    nth1(X1, L, X), 
    nth1(Y1, L, Y),
    X1 is Y1 + 1.

justNext(X,Y,L) :-
    justRight(X, Y, L);
    justRight(Y, X, L) .

oldest(Sol) :-
    length(Sol, 5),    
    member(julio, Sol),
    member(gloria, Sol),
    member(pablo, Sol),
    member(miguel, Sol),
    member(silvia, Sol),
    before(julio,gloria,Sol),
    before(julio,pablo,Sol),
    before(miguel,silvia,Sol),
    before(miguel,pablo,Sol),
    before(gloria,miguel,Sol), !.

farthest(Sol) :-
    length(Sol, 5),   
    member(mote, Sol), 
    member(mova, Sol),
    member(taci, Sol),
    member(dape, Sol),
    member(liru, Sol),
    before(taci,mova,Sol),
    before(dape,liru,Sol),
    before(liru,taci,Sol), !.

%variabless(assignment)
crypto([T,W,O,F,U,R]) :-
    [T,W,O,F,U,R]ins 0..9,
    indomain(O),
    indomain(W),
    indomain(T),
    X1 is (O+O) div 10,
    X2 is (W+W+X1) div 10,
    R is (O+O) mod 10,
    U is (W+W+X1) mod 10,
    O is (T+T+X2) mod 10,
    F is (T+T+X2) div 10,
    all_distinct([T,W,O,F,U,R]).

%lists(permutations)
flowerContest(Sol) :-
    length(Sol,3),
    member([brooke,_],Sol),
    member([virginia,vanity],Sol),
    member([tricia,goldbush],Sol),
    before([brooke,_],[_,vanity],Sol),
    before([brooke,_],[_,goldbush],Sol),
    Sol = [[_,quietness],[_,_],[_,_]],
    Sol = [[_,_],[tricia,_],[_,_]], !.

right(X, Y, L) :-
    (nth1(1,L,X),
    last(L,Y));
    (nth1(X1, L, X),
    nth1(Y1, L, Y),
    X1 is Y1 + 1).

next(X, Y, L) :-
    right(X, Y, L);
    right(Y, X, L) .

family(Sol) :-
    length(Sol, 7),
    member(ben,Sol),
    member(rey,Sol),
    member(luke,Sol),
    member(leia,Sol),
    member(han,Sol),
    member(palpatine,Sol),
    member(anakin,Sol),
    next(ben,rey,Sol),
    \+next(ben,luke,Sol),
    next(luke,leia,Sol),
    next(luke,han,Sol),
    \+next(luke,palpatine,Sol),
    next(palpatine,anakin,Sol),
    \+next(palpatine,leia,Sol),
    next(anakin,ben,Sol), 
    write(Sol).

bestChess(Sol) :-
    length(Sol,4),
    member(erik,Sol),
    member(charles,Sol),
    member(logan,Sol),
    member(scott,Sol),
    before(logan,erik,Sol),
    before(logan,charles,Sol),
    before(scott,charles,Sol),
    before(erik,scott,Sol),!.

items(Sol) :-
    length(Sol,5),
    member(a,Sol),
    member(b,Sol),
    member(c,Sol),
    member(d,Sol),
    member(e,Sol),
    not(justNext(a,b,Sol)),
    not(justNext(a,c,Sol)),
    not(justNext(b,c,Sol)),
    not(justNext(d,e,Sol)).

%[[class,teacher,day],[class,teacher,day],[class,teacher,day]]
schedule(Sol) :-
    length(Sol,3),
    member([math,_,_],Sol),
    member([logic,_,_],Sol),
    member([programming,mary,_],Sol),
    member([_,steve,_],Sol),
    member([_,robert,_],Sol),
    member([_,_,monday],Sol),
    member([_,_,wednesday],Sol),
    member([_,_,friday],Sol),
    before([logic,_,_],[programming,mary,_],Sol),
    \+member([_,robert,monday],Sol),
    \+member([logic,_,monday],Sol),!.

father(carlos,carolina).
father(carlos,gabriela).
father(alejandro,angie).
father(guillermo,fabiola).

mother(olga,carlos).

parent(X,Y) :- father(X,Y).
parent(X,Y) :- mother(X,Y).
parent(X,Y) :- brother(Z,Y), parent(X,Z).

brother(alejandro,carlos).
brother(carlos,alejandro).

son(X,Y) :- parent(Y,X).
son(X,Y) :- brother(X,Z), parent(Y,Z).

cousin(gabriela,fabiola).
cousin(fabiola,gabriela).

granddaughters(X,Y) :- parent(Z,X), parent(Y,Z).
granddaughters(X,Y) :- cousin(X, Z), parent(A,Z), son(A, Y).
  
%[task,duration,startTime,endTime]
pert([[A,B,C],[D,E,F],[G,H,I],[J,K,L]]) :- 
    A is 3,
    B is 0,
    C is A + B,
    D is 8,
    E is C,
    F is D + E,
    G is 5,
    H is C,
    I is G + H,
    J is 4,
    K is F,
    L is J + K.

word(racket,[r,a,c,k,e,t]).
word(haskell,[h,a,s,k,e,l,l]).
word(erlang,[e,r,l,a,n,g]).
word(prolog,[p,r,o,l,o,g]).
word(awesome,[a,w,e,s,o,m,e]).

crossword(A1,D1,D2,A2,D3) :-
    word(A1, [_, A, _, _, B, _]),
    word(A2, [_, C, _, _, _, D, _]),
    word(D1, [A, _, _, _, _, _, _]),
    word(D2, [B, _, _, C, _, _]),
    word(D3, [_, _, _, D, _, _]).

horseRace(Lino,Rubi,Sam,Mac,Chato,Toto,Lulo,Curcho) :-
    P = [1,2,3,4,5,6,7,8],
    member(Lino,P),
    member(Rubi,P),
    member(Sam,P),
    member(Mac,P),
    member(Chato,P),
    member(Toto,P),
    member(Lulo,P),
    member(Curcho,P),
    Lino is Rubi + 3,
    Lino is Sam - 1,
    Mac < Chato,
    Mac > Rubi,
    Lulo is Chato - 3,
    Curcho > 5,
    Toto > Sam,
    all_different([Lino,Rubi,Sam,Mac,Chato,Toto,Lulo,Curcho]).

csp(X1,X2,X3,X4,X5) :-
    A = [1,3,4],
    B = [1,2,3],
    member(X1,A),
    member(X3,A),
    member(X2,B),
    member(X4,B),
    member(X5,B),
    X1 > X2,
    X1 is X3,
    X3 > X2,
    X5 < (X2 + 1),
    X2 < X4.

bags(Sol) :-
    length(Sol,3),
    member([pink,_],Sol),
    member([red,_],Sol),
    member([white,sorghum],Sol),
    member([_,corn],Sol),
    member([_,wheat],Sol),
    \+member([pink,corn],Sol),!.


findPath(L,A,h,Sol) :- makeEdges(L), path(A,h,Sol).

makeEdges([]).
makeEdges([[A,B,C] | T]) :- assertz(edge(A,B,C)), makeEdges(T).

path(X,h,[[X,h],C]) :- edge(X, h, C).
path(X,h,[[ X | L ], C]) :- 
    edge(X, A, W),
    path(A,h,[L, Z]), 
    C is Z + W.
