erlang-bertrpc-client
=====================

# Erlang BERT-RPC client

implementation of BERT-RPC client in Erlang

[bert-rpc](http://bert-rpc.org/)


## instruction in Erlang

    eos@bertrpc:call("127.0.0.1",9999,lists,reverse,[ [1,2,3] ]).

## instruction in ErlangEOS

    Bert = #<bertrpc>{ server="127.0.0.1",port=9999 }
    Bert.lists.reverse([1,2,3])


#author,homepage
- http://throben.org/
- twitter: @zed_throben https://twitter.com/zed_throben