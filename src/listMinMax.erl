%% @author attack
%% @doc @todo Add description to listMinMax.

-module(listMinMax).
-export([find_max/1, find_min/1, find_odd_nums/1, find_even_nums/1, reverse/1, sum/1]).


%% find_max===================================
find_max([Head|Tail]) ->
	find_max(Tail, Head).

find_max([], Tail) ->
	Tail;
find_max([Head|Tail], Max) ->
	if Head > Max -> find_max(Tail, Head);
		true -> find_max(Tail, Max)
	end.

%% finMin=====================================
find_min([H | T]) ->
	find_min(T, H).

find_min([], T) -> T;
find_min([H | T], Min) ->
	if H < Min -> find_min(T, H);
		true -> find_min(T, Min)
	end.

%% find odd numbers===========================
find_odd_nums(L) -> find_odd_nums(L, []).

find_odd_nums([], Acc) -> reverse(Acc);
find_odd_nums([H | T], Acc) ->
	if (H rem 2) == 0 -> find_odd_nums(T, [H | Acc]);
		true -> find_odd_nums(T, Acc)
	end.

%% find even numbers==========================
find_even_nums(L) -> find_even_nums(L, []).

find_even_nums([], Acc) -> reverse(Acc);
find_even_nums([H | T], Acc) ->
	if (H rem 2) /= 0 -> find_even_nums(T, [H | Acc]);
		true -> find_even_nums(T, Acc)
	end.

%% reverse list===============================
reverse(L) -> reverse(L, []).

reverse([], Acc) -> Acc;
reverse([H | T], Acc) -> reverse(T, [H | Acc]).

%% sum========================================
sum(L) -> sum(L, 0).

sum([], Acc) -> Acc;
sum([H | T], Acc) -> sum(T, Acc + H).