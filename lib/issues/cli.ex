defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [count | #{@default_count}]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_in_descending_order()
    |> last(count)
    |> Issues.Printer.paint(["number", "created_at", "title"])
  end

  def process({user, project}) do
    process({user, project, @default_count})
  end

  def sort_in_descending_order(issues) do
    issues
    |> Enum.sort(fn item1, item2 ->
        item1["created_at"] <= item2["created_at"]
      end)
  end

  defp last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse
  end

  defp decode_response({:ok, body}), do: body
  defp decode_response({:erro, error}) do
    IO.puts "Error fetching from Github: #{error}"
    System.halt(2)
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.

  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> map_args()
  end

  defp map_args([user, project, count]) do
    { user, project, String.to_integer(count) }
  end
  defp map_args([user, project]), do: { user, project, @default_count }
  defp map_args(_), do: :help
end
