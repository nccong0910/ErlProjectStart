%% @author attack
%% @doc @todo Add description to skeleton.


-module(skeleton).
-export([collatz/1, skeleton/1]).

%% [1,2,[[3],4],5] -> [[],[],[[[]],[]],[]]
skeleton(L) -> skeleton(L, []).

skeleton([], Acc) -> lists:reverse(Acc);
skeleton([H | T], Acc) ->
	case H of
		[_|_] -> skeleton(T, [skeleton(H) | Acc]);
		_		-> skeleton(T, [[] | Acc])
	end.

%% Returns a list starting with N. Each subsequent value is computed from the previous value according to this rule:
%% The list ends with 1.
%% Every even number is followed by half that number.
%% Every odd number (except 1) is followed by three times that number, plus 1.
%% example: 3 -> [3,10,5,16,8,4,2,1]
collatz(N)-> collatz(N, []).

collatz(1, Acc) -> lists:reverse([1 | Acc]);
collatz(N, Acc) ->
	if N rem 2 == 0 -> collatz(N div 2, [N | Acc]);
		true -> collatz(N*3 + 1, [N | Acc])
	end.


