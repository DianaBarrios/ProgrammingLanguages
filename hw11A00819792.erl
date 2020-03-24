-module(hw11A00819792).
-export([pow/2, fibonacci/1, reverse/1, count/2]).
% Complete the following functions and submit your file to Canvas.
% ========= IMPORTANT ==========
% Change the name of the file so that it contains your student ID or name.
% Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
% Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
% Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
% If your file cannot be loaded by the Erlang compiler, your grade will be zero. Then, submit only code that works.

powAux(N,E,R) -> if
    E =< 0 -> R;
    true -> powAux(N,E-1,R*N)
end.
% pow (tail recursive version)
pow(N,E) -> powAux(N,E,1).

fibonacciAux(X,N,M) -> if
    X =< 0 -> M;
    true -> fibonacciAux(X-1,M,N+M)
end.

% Fibonacci (tail recursive version)
fibonacci(X) -> fibonacciAux(X,0,1).

reverseAux(X,Y) -> if
    length(X) == 0 -> Y;
    true -> reverseAux(tl(X), [hd(X)|Y])
end.

% reverse (tail recursive version)
reverse(X) -> reverseAux(X,[]).

countAux(X,N,C) -> if
    length(X) == 0 -> C;
    hd(X) == N -> countAux(tl(X),N,C+1);
    true -> countAux(tl(X),N,C)
end.

% count (tail recursive version
count(X,N) -> countAux(X,N,0).