%% @author attack
%% @doc @todo Add description to chat_server.

-module(chat_server).
-behaviour(gen_server).
-export([start_link/0, send_msg/2, get_users/0, add_user/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% Public
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

send_msg(Pid, Msg) ->
    gen_server:call(?MODULE, {sendmsg, Pid, Msg}).

get_users() ->
    gen_server:call(?MODULE, {get_users}).

add_user(Pid) ->
	gen_server:cast(?MODULE, {adduser, Pid}).

%% Private

init([]) ->
	State = [pid1],
    {ok, State}.

handle_call({sendmsg, Pid, _Msg}, _From, State) ->
	Reply = lists:member(Pid, State),
    {reply, Reply, State};

handle_call({get_users}, _From, State) ->
    {reply, {ok, State}, State};

handle_call(Request, _From, State) ->
    error_logger:warning_msg("Bad message: ~p~n", [Request]),
    {reply, {error, unknown_call}, State}.

handle_cast({adduser, Name}, State) ->
	NewState = [Name | State],
    io:format("NewState: ~p ~n", [NewState]),
    {noreply, NewState};

handle_cast(Msg, State) ->
    error_logger:warning_msg("Bad message: ~p~n", [Msg]),
    {noreply, State}.

%% Other gen_server callbacks
handle_info(Info, State) ->
    error_logger:warning_msg("Bad message: ~p~n", [Info]),
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
