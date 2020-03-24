-module(hw12A00819792).

-export([appendNumber/1, balance/1, bank/1, client/0,
	 createAccount/2, deposit/2, fact/3, factAux/4,
	 factorial/1, friendOrFoe/1, marco/2, polo/2, run/0,
	 startBank/0, startFoF/2, statusBank/0, stopBank/0,
	 withdraw/2]).

appendNumber(A) ->
    receive
      X when is_number(X), X > 0 ->
	  io:format("Number ~p has been added to the list.", [X]),
	  appendNumber(A ++ [X]);
      _ ->
	  io:format("The numbers registered by the process "
		    "are: ~p\n",
		    [A])
    end.

factAux(Pid, N, C, R) ->
    if N == C -> R;
       true -> factAux(Pid, N - 1, C, N * R)
    end.

fact(Pid, N, C) -> X = factAux(Pid, N, C, 1), Pid ! X.

factorial(N) ->
    spawn(hw12A00819792, fact, [self(), trunc(N / 2), 0]),
    spawn(hw12A00819792, fact, [self(), N, trunc(N / 2)]),
    receive
      X when is_number(X) -> io:format("Received")
    end,
    receive
      Y when is_number(Y) ->
	  io:format("Result: ~p ~p\n", [X, Y]), X * Y
    end.

friendOrFoe(Color) ->
    receive
      {Pid, M} ->
	  Pid ! {self(), check, M}, friendOrFoe(Color);
      {PName, check, M} ->
	  PName ! {self(), Color, M}, friendOrFoe(Color);
      {Pid, C, M} when C == Color ->
	  io:format("Received a message from a friend process, "
		    "~p: ~p\n",
		    [Pid, M]),
	  friendOrFoe(Color);
      {Pid, C, M} when C /= Color ->
	  io:format("Process ~p is not my friend. I will "
		    "ignore its message. ~p\n",
		    [Pid, M]),
	  friendOrFoe(Color)
    end.

startFoF(Id, Color) ->
    register(Id,
	     spawn(hw12A00819792, friendOrFoe, [Color])).

marco(XPos, YPos) ->
    receive
      {_, 0, 0} ->
	  io:format("Marco moves to (~p,~p)\n", [XPos, YPos]);
      {Pid, MoveX, MoveY} ->
	  io:format("Marco moves to (~p,~p)\n",
		    [XPos + MoveX, YPos + MoveY]),
	  Pid ! {self(), XPos + MoveX, YPos + MoveY},
	  marco(XPos + MoveX, YPos + MoveY)
    end.

polo(XPos, YPos) ->
    receive
      {Pid, X, Y} when X == XPos, Y == YPos ->
	  Pid ! {self(), 0, 0},
	  io:format("Marco found me! I was hiding at position "
		    "(~p,~p)\n",
		    [XPos, YPos]);
      {Pid, X, Y} when X == XPos ->
	  Pid ! {self(), 0, (YPos - Y) / abs(YPos - Y)},
	  polo(XPos, YPos);
      {Pid, X, Y} when Y == YPos ->
	  Pid ! {self(), (XPos - X) / abs(XPos - X), 0},
	  polo(XPos, YPos);
      {Pid, X, Y} ->
	  Pid !
	    {self(), (XPos - X) / abs(XPos - X),
	     (YPos - Y) / abs(YPos - Y)},
	  polo(XPos, YPos)
    end.

run() ->
    MXPos = rand:uniform(20),
    MYPos = rand:uniform(20),
    PXPos = rand:uniform(20),
    PYPos = rand:uniform(20),
    register(marcoPid,
	     spawn(hw12A00819792, marco, [MXPos, MYPos])),
    register(poloPid,
	     spawn(hw12A00819792, polo, [PXPos, PYPos])),
    poloPid ! {marcoPid, MXPos, MYPos}.

bank(D) ->
    receive
      {create, Acc, Amount} ->
	  io:format("Registered client~n"),
	  bank(orddict:store(Acc, Amount, D));
      {balance, Acc} ->
	  case orddict:is_key(Acc, D) of
	    true ->
		clientID ! {balance, orddict:find(Acc, D)}, bank(D);
	    false -> client ! {balance, error}, bank(D)
	  end;
      {deposit, Acc, Amount} ->
	  case orddict:is_key(Acc, D) of
	    true ->
		clientID ! {deposit, Amount},
		bank(orddict:update_counter(Acc, Amount, D));
	    false -> clientID ! {deposit, error}, bank(D)
	  end;
      {withdraw, Acc, Amount} ->
	  case orddict:is_key(Acc, D) of
	    true ->
		clientID ! {withdraw, Amount},
		bank(orddict:update_counter(Acc, -Amount, D));
	    false -> clientID ! {withdraw, error}, bank(D)
	  end;
      status ->
	  io:format("The status of the accounts are:~n~p~n",
		    [orddict:to_list(D)]),
	  bank(D);
      stop ->
	  self() ! status,
	  io:format("The bank is closing now. Bye!~n", [])
    end.

client() ->
    receive
      {balance, error} ->
	  io:format("The account doesn't exist.~n", []), client();
      {balance, {ok, Amount}} ->
	  io:format("Your account balance is: $~p~n", [Amount]),
	  client();
      {deposit, error} ->
	  io:format("Your account doesn't exist.~n", []),
	  client();
      {deposit, Amount} ->
	  io:format("Your account has been deposited $~p.~n",
		    [Amount]),
	  client();
      {withdraw, error} ->
	  io:format("Your account cannot be credited that "
		    "amount.~n",
		    []),
	  client();
      {withdraw, Amount} ->
	  io:format("Your have withdrawn $~p from your account.~n",
		    [Amount]),
	  client()
    end.

startBank() ->
    io:format("The bank is opening. Welcome!~n", []),
    register(clientID, spawn(hw12A00819792, client, [])),
    register(bankID,
	     spawn(hw12A00819792, bank, [orddict:new()])).

stopBank() -> bankID ! stop.

createAccount(_, N) when N < 500 ->
    io:format("The minimum amount to open an account "
	      "is $500.~n",
	      []);
createAccount(A, N) when N >= 500 ->
    io:format("Your account has been created with $~p.~n",
	      [N]),
    bankID ! {create, A, N}.

balance(A) -> bankID ! {balance, A}.

deposit(_, N) when N < 20 ->
    io:format("The minimum amount to deposit is $20.~n",
	      []);
deposit(A, N) -> bankID ! {deposit, A, N}.

withdraw(_, N) when N < 1 ->
    io:format("The minimum amount to withdraw is $1.~n",
	      []);
withdraw(A, N) -> bankID ! {withdraw, A, N}.

statusBank() -> bankID ! status.
