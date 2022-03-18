%% @author attack
%% @doc @todo Add description to greet_server.


-module(greet_server).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3, greet/2, asks/2]).


start_link() ->
    Return = gen_server:start_link({local, ?MODULE}, ?MODULE, [], []),
    io:format("start_link: ~p~n", [Return]),
    Return.

greet(Pid, Name) ->
	gen_server:cast(Pid, {greet, Name}).

asks(Pid, Msg) ->
	gen_server:call(Pid, {ask, Msg}).


init([]) ->
	{ok,[]}.

handle_call({ask, Msg}, From, Stage) ->
	io:format("handle_call: Receive msg ~p from ~p ~n",[Msg,From]),
	{reply, ok, Stage};
handle_call(Request, From, Stage) ->
	io:format("handle_call: Bad msg ~p from ~p ~n",[Request,From]),
	{reply, ok, Stage}.

handle_cast({greet, Name}, stage) ->
	io:format("handle_cast: Greet ~p~n.", [Name]),
	{noreply, stage};
handle_cast(Msg, State) ->
    io:format("handle_cast: ~p~n", [Msg]),
    {noreply, State}.


handle_info(_Info, State) ->
    Return = {noreply, State},
    io:format("handle_info: ~p~n", [Return]),
    Return.

terminate(_Reason, _State) ->
    Return = ok,
    io:format("terminate: ~p~n", [Return]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    Return = {ok, State},
    io:format("code_change: ~p~n", [Return]),
    Return.



