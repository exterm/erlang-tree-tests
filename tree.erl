-module(tree).

-export([is_elem/2, example_tree/0, test/0, zip_with/3]).

-type non_empty_tree(ElType) :: {Value :: ElType,
                                 Left  :: tree(ElType),
                                 Right :: tree(ElType)}.
-type tree(ElType) :: nothing | non_empty_tree(ElType).

-spec is_elem(V, tree(V)) -> boolean().
is_elem(_Elem, nothing)              -> false;
is_elem(Elem, {Elem, _Left, _Right}) -> true;
is_elem(Elem, {_, Left, Right})      -> is_elem(Elem, Left) or is_elem(Elem, Right).

% trees need to have the same structure, type system can not express that
-spec zip_with(fun((A,B) -> C), tree(A), tree(B)) -> tree(C).
zip_with(_, nothing, nothing) ->
    nothing;
zip_with(F, {E1, Left1, Right1}, {E2, Left2, Right2}) ->
    {F(E1,E2), zip_with(F, Left1, Left2), zip_with(F, Right1, Right2)}.

-spec example_tree() -> non_empty_tree(integer()).
example_tree() ->
    {1,
     {2,
      {3, nothing, nothing},
      nothing},
     {4,
      nothing,
      {5, nothing, nothing}}}.

-spec test() -> ok.
test() ->
    false = is_elem(42, example_tree()),
    false = is_elem(6, example_tree()),
    true = is_elem(5, example_tree()),
    true = is_elem(1, example_tree()),
    DoubledTree = zip_with(fun(A,B) -> A+B end, example_tree(), example_tree()),
    true = is_elem(6, DoubledTree),
    false = is_elem(1, DoubledTree),
    ok.
