- compile(export_all).
- module(eos@bertrpc).
- define(eos(A,B),{eos,A,B}).
- define(TIMEOUT,1000*60).

new(Options,Params) ->
    {server,Server} = proplists:lookup(server,Params),
    {port,Port} = proplists:lookup(port,Params),
    ?eos(eos@bertrpc,{{Server,Port,undefined},[]}).

invoke(?eos(eos@bertrpc,{{Server,Port,_},Module}),Method,Params) ->
    call(Server,Port,Module,Method,Params).

call(Server,Port,Module,Method,Params) ->
    {ok,Sock} = gen_tcp:connect(Server,Port,[binary,{packet,raw},{active,false}]),
    A = bert:encode({call,Module,Method,Params}),
    ByteSize = byte_size(A),
    BinSize = <<ByteSize:32>>,
    R1 = gen_tcp:send(Sock,BinSize),
    R2 = gen_tcp:send(Sock,A),
    RR1 = gen_tcp:recv(Sock,4),
    {ok,RSz} = RR1,
    <<ResLen:32>> = RSz,
    RR2 = gen_tcp:recv(Sock,ResLen),
    {ok,ReplyBin} = RR2,
    Reply = bert:decode(ReplyBin),
    catch gen_tcp:close(Sock),
    case Reply of
        {reply, X} -> 
            X;
        _ -> 
            Reply
        
    end.

get_slot(?eos(eos@bertrpc,{Conn,[]}),Key) ->
    ?eos(eos@bertrpc,{Conn,Key}).
