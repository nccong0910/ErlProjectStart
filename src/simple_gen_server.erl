%% @author attack
%% @doc @todo Add description to simple_gen_server.


-module(simple_gen_server).
-behaviour(gen_server).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

start_link() ->
    Return = gen_server:start_link({local, ?MODULE}, ?MODULE, [], []),
    io:format("start_link: ~p~n", [Return]),
    Return.

init([]) ->
    State = [],
    Return = {ok, State},
    io:format("init: ~p~n", [State]),
    Return.
	
handle_call(get_status, _From, State) ->
    Reply = get_status_ok,
    {reply, Reply, State};
	
handle_call({wfmsg,Msg}, From, State) ->
    io:format("Receive msg ~p from ~p ~n",[Msg,From]),
    {reply, ok, State};

handle_call(Request, From, State) ->
    io:format("handle_call ex ~p ~n",[Request]),
    Reply = ok,
    Return = {reply, Reply, State},
    io:format("handle_call: ~p~n", [Return]),
    Return.

handle_cast({wfmsg,Msg}, State) ->
    io:format("Receive msg from handle_cast: ~p~n", [Msg]),
    {noreply, State};

handle_cast(Msg, State) ->
    Return = {noreply, State},
    io:format("handle_cast: ~p~n", [Return]),
    Return.
	

handle_info({wfmsg,Msg}, State) ->
    erlang:send_after(1000,helloworld,{wfmsg,"Msg abcdasd"}),
    io:format("handle_cast Msg: ~p~n", [Msg]),
    {noreply, State};

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