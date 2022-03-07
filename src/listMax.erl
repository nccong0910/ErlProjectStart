%% @author attack
%% @doc @todo Add description to listMax.

-module(listMax).

%% ====================================================================
%% API functions
%% ====================================================================
-export([findMax/1]).

%% ====================================================================
%% Internal functions
%% ====================================================================

findMax([Head|Tail]) ->
	findMax(Tail, Head).

findMax([], Tail) ->
	Tail;
findMax([Head|Tail], Max) when Head > Max ->
	New_Max = Head,
	findMax(Tail, New_Max).