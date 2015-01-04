-module(tree).

-export([is_elem/2, example_tree/0, test/0]).

-type non_empty_tree(ElType) :: {Value :: ElType,
                                 Left  :: tree(ElType),
                                 Right :: tree(ElType)}.
-type tree(ElType) :: nothing | non_empty_tree(ElType).

is_elem(_Elem, nothing)              -> false;
is_elem(Elem, {Elem, _Left, _Right}) -> true;
is_elem(Elem, {_, Left, Right})      -> is_elem(Elem, Left) or is_elem(Elem, Right).

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
    ok.
