%% @author attack
%% @doc @todo Add description to mapMethods.


-module(mapMethods).

%% ====================================================================
%% API functions
%% ====================================================================
-export([size_method/0, filter_method/0, filtermap_method/0, find_method/0]).

%% ====================================================================
%% Internal functions
%% ====================================================================

size_method() ->
	M = #{a => 2, b => 3, c=> 4, "a" => 1, "b" => 2, "c" => 4},
	io:format("size map: ~w~n", [maps:size(M)]).

filter_method() ->
	M = #{a => 2, b => 4, c=> 6, "a" => 1, "b" => 2, "c" => 4},
	Pred = fun (K, V) -> is_atom(K) andalso V rem 2 == 0 end,
	maps:filter(Pred, M).

filtermap_method() ->
	Func = fun(K, V) when is_atom(K) -> {true, V*2}; (_, V) -> V rem 2 == 0 end,
	M = #{a => 1, b => 2, "c"=> 3, "d" => 4},
	maps:filtermap(Func, M).

find_method() ->
	M = #{a => 1, b => 2, c => 3},
	maps:find(c, M).

