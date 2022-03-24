%% @author Administrator
%% @doc @todo Add description to file_write.


-module(file_write).

%% ====================================================================
%% API functions
%% ====================================================================
-export([send/2, coppy/2]).

send(File1, File2) ->
	{ok, F1} = file:open(File1, read),
	{ok, Data} = file:read(F1, 10),
	io:format("data: ~p~n", [Data]),
	file:write_file(File2, Data, [append]).
	
coppy(File1, File2) ->
	file:copy(File1, File2).
%% ====================================================================
%% Internal functions
%% ====================================================================


