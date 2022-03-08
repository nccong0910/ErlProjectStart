%% @author attack
%% @doc @todo Add description to findString.


-module(findString).
-export([normal_find/0]).

%% no use recursion
normal_find() ->
	S1 = "Cong",
	S2 = "Nguyen Chi Cong",
	LS2 = string:lexemes(S2, " "),
	io:format("~p~n~p~n", [S1,LS2]),
	Pred = fun(L) -> L == S1 end,
	lists:filter(Pred, LS2).
	


