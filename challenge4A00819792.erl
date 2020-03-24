-module(challenge4A00819792).
-export([respond/0]).

respond() ->
    receive
        X when is_number(X) -> io:format("~p\n",[X+1]),respond();
        _ -> io:format("Bye\n")
    end.