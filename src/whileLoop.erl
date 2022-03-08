%% @author attack
%% @doc @todo Add description to whileLoop.

-module(whileLoop).
-export([loop/1, do_while/0]).

%% while: from Count to 1
loop(0) -> oke;
loop(Count) ->
	io:format("~w~n", [Count]),
	loop(Count-1).

%% do while: from 1 to 10
do_while() ->
	while(1).

while(10) ->
	oke;
while(Count) ->
	io:format("~w~n", [Count]),
	while(Count+1).
  
  
  
  
  