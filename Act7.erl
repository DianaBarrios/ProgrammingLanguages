-module(Act7).
-export([removeFirst/1, sumAllElements/1])

quicksort([]) -> [];
quicksort([H | L]) -> quicksort(lists:filter(fun(X) -> X < H end, L)) ++ [H | quicksort(lists:filter(fun(X) -> X > H end, L))].