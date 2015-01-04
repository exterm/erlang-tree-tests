-module(tree2).

-export([is_elem/2, example_tree/0, test/0]).

-record(non_empty_tree, {
          value,
          right = nothing :: tree(),
          left = nothing :: tree()
         }).

-type tree() :: nothing | #non_empty_tree{}.

-spec is_elem(any(), tree()) -> boolean().
is_elem(_Elem, nothing) ->
    false;
is_elem(Elem, #non_empty_tree{value=Elem}) ->
    true;
is_elem(Elem, #non_empty_tree{left = Left,
                              right = Right}) ->
    is_elem(Elem, Left) or is_elem(Elem, Right).

-spec example_tree() -> #non_empty_tree{}.
example_tree() ->
    #non_empty_tree{
       value=1,
       left = #non_empty_tree{
                 value = 2,
                 left = #non_empty_tree{value = 3}},
       right = #non_empty_tree{
                  value = 4,
                  right = #non_empty_tree{value = 5}}}.

-spec test() -> ok.
test() ->
    false = is_elem(42, example_tree()),
    false = is_elem(6, example_tree()),
    true = is_elem(5, example_tree()),
    true = is_elem(1, example_tree()),
    ok.
