%% @author attack
%% @doc @todo Add description to myReverse.


-module(myReverse).
-export([simple_reverse/1, deep_reverse/1]).

%% simple reverse==================================================================
simple_reverse(L) -> simple_reverse(L, []).

simple_reverse([], Acc) -> Acc;
simple_reverse([H | T], Acc) ->
	simple_reverse(T, [H | Acc]).

%% deep reverse====================================================================
deep_reverse(L) -> deep_reverse(L, []).

deep_reverse([], Acc) -> Acc;
deep_reverse([H | T], Acc) ->
	case H of
		[_|_] -> deep_reverse(T, [deep_reverse(H) | Acc]);
		_	  -> deep_reverse(T, [H | Acc])
	end.

