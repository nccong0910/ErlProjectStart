
%% @doc @todo Add description to dump_subdata.

-module(dump_subdata_client).
-behaviour(gen_fsm).

-export([start_fsm/1,send_init/1,send_data/2,send_finish/1]).

-export([start_link/1,
		 init/1,
		 wf_init_ack/2,
		 wf_subscriber_data_dump_ack/2,
		 handle_event/3, 
		 handle_sync_event/4, 
		 handle_info/3, 
		 terminate/3, 
		 code_change/4]).

-define(INIT_SESSION, init_session).
-define(SUBSCRIBER_DATA_DUMP, subscriber_data_dump).
-define(SUBSCRIBER_DATA_DUMP_END, subscriber_data_dump_end).
-define(SUBSCRIBER_DATA_DUMP_ABORT, subscriber_data_dump_abort).

-record(event, {						
	id		:: tuple(),							
	orig	:: pid(),							
	dest	:: {atom(),node()} | pid(),			
	header	:: any(),							
	body	:: any()							
}).

start_link(Args) ->
	gen_fsm:start_link(?MODULE, {Args}, []).

init({FilePath}) ->
	StateData = ["a\n", "b\n", "c\n"],
	{ok, Pid} = dump_subdata:start_link(FilePath),
	gen_fsm:send_event(Pid, #event{id=?INIT_SESSION,
									orig=self(),
									dest=Pid,
									body=self()}),
	{ok, wf_init_ack, StateData}.
	
wf_init_ack(#event{id = init_ack, orig = DestPid}, StateData) ->
	io:format("wf_init_ack ~p, StateData:~p~n", [DestPid, StateData]),
	gen_fsm:send_event(DestPid, #event{id=?SUBSCRIBER_DATA_DUMP,
					  orig=self(),
					  dest=DestPid,
					  body=self()}),
	{next_state, wf_subscriber_data_dump_ack, StateData}.

wf_subscriber_data_dump_ack(#event{id = subscriber_data_dump_ack, orig = DestPid}, StateData) ->
	io:format("StateData: ~p~n", [StateData]),
	case StateData of
		[H|T] -> NewState = T,
				 gen_fsm:send_event(DestPid, #event{id=?SUBSCRIBER_DATA_DUMP,
									  orig=self(),
									  dest=DestPid,
									  body=H}),
				 io:format("Send data: ~p~n", H),
				 {next_state, wf_subscriber_data_dump_ack, NewState};

		[] -> NewState = [],
			  gen_fsm:send_event(DestPid, #event{id=?SUBSCRIBER_DATA_DUMP_END,
									  orig=self(),
									  dest=DestPid}),
			  {stop, normal, NewState}
	end.
	
%% ====================================================================

handle_event(_Event, StateName, StateData) ->
    {next_state, StateName, StateData}.

handle_sync_event(_Event, _From, StateName, StateData) ->
    Reply = ok,
    {reply, Reply, StateName, StateData}.

handle_info(_Info, StateName, StateData) ->
    {next_state, StateName, StateData}.

terminate(Reason, _, _StatData) ->
	io:format("terminate with reason ~p~n",[Reason]),
	Reason.

code_change(_OldVsn, StateName, StateData, _Extra) ->
    {ok, StateName, StateData}.

%% ====================================================================
start_fsm(FilePath)->
	dump_subdata:start_link(FilePath).

send_init(DestPid)->
	gen_fsm:send_event(DestPid, #event{id=?INIT_SESSION,
									orig=self(),
									dest=DestPid,
									body=self()}).

send_data(DestPid,SubData)->
	gen_fsm:send_event(DestPid, #event{id=?SUBSCRIBER_DATA_DUMP,
									  orig=self(),
									  dest=DestPid,
									  body=SubData}).

send_finish(DestPid)->
	gen_fsm:send_event(DestPid, #event{id=?SUBSCRIBER_DATA_DUMP_END,
									  orig=self(),
									  dest=DestPid}).