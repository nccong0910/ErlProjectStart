%% @author attack
%% @doc @todo Add description to forLoop.


-module(forLoop).

%% ====================================================================
%% API functions
%% ====================================================================
-export([for/1]).

for(0)
  -> [];
for(N) when N > 0 -> 
   io:fwrite("Hello~n"), 
   for(N-1).

%% ====================================================================
%% Internal functions
%% ====================================================================


