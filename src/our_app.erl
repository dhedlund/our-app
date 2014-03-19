-module(our_app).
-behavior(application).
 
-export([start/2]).
-export([stop/1]).
 
start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        %% {URIHost, list({URIPath, Handler, Opts})}
        {'_', [{'_', our_handler, []}]}
    ]),
    %% Name, NbAcceptors, TransOpts, ProtoOpts
    cowboy:start_http(my_http_listener, 100,
        [{ip, {127,0,0,1}}, {port, 8080}],
        [{env, [{dispatch, Dispatch}]}]
    ),
    our_sup:start_link().

 
stop(_State) ->
    ok.
