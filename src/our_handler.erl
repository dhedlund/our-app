-module(our_handler).
-behavior(cowboy_http_handler).
 
-export([init/3]).
-export([handle/2]).
-export([terminate/3]).
 
init(_Type, Req, _Opts) ->
    eredis_pool:q(rpool,
      ["SET", "content", "Our app is a very very very fine app!"]
    ),

    {ok, Req, undefined_state}.
 
handle(Req, State) ->
    {ok, Body} = eredis_pool:q(rpool, ["GET", "content"]),

    {ok, Req2} = cowboy_req:reply(200, [
        {<<"content-type">>, <<"text/plain">>}
    ], Body, Req),
    {ok, Req2, State}.
 
terminate(_Reason, _Req, _State) ->
    ok.
