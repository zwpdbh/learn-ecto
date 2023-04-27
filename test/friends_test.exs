defmodule FriendsTest do
  use ExUnit.Case
  # option01: use Friends.RepoCase

  doctest Friends

  # option02
  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Friends.Repo)
  end

  test "greets the world" do
    assert Friends.hello() == :world
  end

  test "test database 01" do
    result =
      Friends.Person.demo_query_all()
      |> IO.inspect()
      |> length()

    assert result == 3
  end

  test "test database 02" do
    Friends.Person.demo_delete()

    result =
      Friends.Person.demo_query_all()
      |> IO.inspect()
      |> length()

    assert result == 2
  end
end
