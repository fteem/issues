defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1, sort_in_descending_order: 1 ]

  test ":help is returned when -h or --help are used as options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three are given" do
    assert parse_args(["user", "project", "123"]) == { "user", "project", 123 }
  end

  test "count is defaulted if two values are given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort in descending orders the correct way" do
    result = [3, 1, 2]
             |> fake_created_at_list
             |> sort_in_descending_order
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == [1, 2, 3]
  end

  defp fake_created_at_list(values) do
    for value <- values, do: %{"created_at" => value, "rest" => "foo"}
  end
end
