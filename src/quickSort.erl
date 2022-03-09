%% @author Administrator
%% @doc @todo Add description to quickSort.


-module(quickSort).
-export([quick_sort/1]).

quick_sort([]) -> [];
quick_sort([Pivot | Rest]) ->
	{Left, Right} = partition(Pivot, Rest, [], []),
	quick_sort(Left) ++ [Pivot] ++ quick_sort(Right).

partition(_, [], Left, Right) -> {Left, Right};
partition(Pivot, [H | T], Left, Right) ->
	if H =< Pivot -> partition(Pivot, T, [H | Left], Right);
	   H > Pivot -> partition(Pivot, T, Left, [H | Right])
	end.