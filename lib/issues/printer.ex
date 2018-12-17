defmodule Issues.Printer do
  @default_columns ~w(number created_at title)

  def paint(issues) do
    paint(issues, @default_columns)
  end

  def paint(issues, columns) do
    rows(issues, columns)
    |> Scribe.print
  end

  def rows(issues, columns) do
    issues |> Enum.map(fn issue -> row(issue, columns) end)
  end

  defp row(issue, columns) do
    Map.take(issue, columns)
  end
end
