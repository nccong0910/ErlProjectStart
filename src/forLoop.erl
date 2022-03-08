%% @author attack
%% @doc @todo Add description to forLoop.


-module(forLoop).
-export([for/1, tail_length/1]).

%% ========================================================
for(0)
  -> [];
for(N) when N > 0 -> 
   io:fwrite("Hello~n"), 
   for(N-1).

%% length of list using tail recursion=====================
tail_length(L) -> tail_length(L, 0).

tail_length([], Acc) -> Acc;
tail_length([_ | T], Acc) -> tail_length(T, Acc + 1).


