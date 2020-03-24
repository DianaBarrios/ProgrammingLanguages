-module(hw13A0819792).

-export([getBalance/1, matrixSum/2, peek/1, pop/1,
	 push/2, search/2]).

% Complete the following functions and submit your file to Canvas.

% ========= IMPORTANT ==========
% Change the name of the file so that it contains your student ID or name.
% Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
% Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
% Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
% If your file cannot be loaded by the Erlang compiler, your grade will be zero. Then, submit only code that works.

% Lists to represent stacks
push(L, N) -> [N | L].

pop([_ | T]) -> T.

peek([H | _]) -> H.

% Matrix addition
matrixSum(M1, M2) ->
    lists:zipwith(fun (X, Y) ->
			  lists:zipwith(fun (I, J) -> I + J end, X, Y)
		  end,
		  M1, M2).

% Get balance
% [{charge, 1000}, {charge, 2000}, {payment, 500}, {payment, 3000}, {charge, 3500}]
getBalance([]) -> 0;
getBalance([{C, N} | T]) ->
    if C == charge -> getBalance(T) - N;
       true -> N + getBalance(T)
    end.

% Search in binary trees
%[8, [5, [2, [], []], [7, [], []]], [9, [], [15, [11, [], []]]]]
search([], _) -> false;
search([H | T], N) ->
    if H == N -> true;
       true ->
	   X = lists:filter(fun (S) -> S == true end,
			    lists:map(fun (L) -> search(L, N) end, T)),
	   if X == [true] -> true;
	      true -> false
	   end
    end.
