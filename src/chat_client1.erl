%% @author attack
%% @doc @todo Add description to chat_client1.


-module(chat_client1).
-behaviour(gen_server).
-export([start_link/0, send_msg/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% Public
send_msg(Msg, To) ->
	gen_server:call(?MODULE, {sendmsg, Msg, To}).

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, {}, []).

%% Private
init({}) ->
	{ok, []}.

handle_call({sendmsg, Msg, To}, _From, State) ->
    io:format("Message from ~p: ~p~n", [self(), Msg]),
    {reply, chat_server:send_msg(To, Msg), State};

handle_call(_Request, _From, State) ->
    Reply = ok,
    Return = {reply, Reply, State},
    io:format("handle_call: ~p~n", [Return]),
    Return.

handle_cast(_Msg, State) ->
    Return = {noreply, State},
    io:format("handle_cast: ~p~n", [Return]),
    Return.

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