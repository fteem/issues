defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1 ]

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
end
