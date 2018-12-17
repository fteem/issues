defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      name: "Issues",
      source_url: "https://github.com/fteem/issues",
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript_config()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :httpoison, "~> 1.5.0" },
      { :poison, "~> 4.0.1" },
      { :scribe, "~> 0.8" },
      { :ex_doc, "~> 0.19.1" },
      { :earmark, "~> 1.3.0" }
    ]
  end

  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
