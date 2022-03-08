%% @author attack
%% @doc @todo Add description to findString.


-module(findString).
-export([filter_find/0, str_find/0, recur_find/2]).


%% use recursion===============================================
recur_find(S1, S2) ->
	io:format("~p~n~p~n", [S1, S2]),
	recur_func(S1, S2).

recur_func([], _) -> true;
recur_func([H1 | T1], [H2 | T2]) ->
	if H1 /= H2 -> recur_func([H1 | T1], T2);
	   H1 == H2 -> recur_func(T1, T2)
	end;
recur_func(_, _) -> false.

%% use str of string============================================
str_find() ->
	S1 = "Cong",
	S2 = "Nguyen Chi Cong",
	Condision = string:str(S1, S2),
	check(Condision).

check(0) -> 0;
check(_) -> "ok".


%% use filter of list===========================================
filter_find() ->
	S1 = "Cong",
	S2 = "Nguyen Chi Cong",
	LS2 = string:lexemes(S2, " "),
	io:format("~p~n~p~n", [S1,LS2]),
	Pred = fun(L) -> L == S1 end,
	lists:filter(Pred, LS2).
	



