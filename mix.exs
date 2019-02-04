defmodule Octo.MixProject do
  use Mix.Project

  @url "https://github.com/connorjacobsen/octo"

  def project do
    [
      app: :octo,
      version: "0.1.1",
      elixir: "~> 1.7",
      description: "Ecto.Repo read/write facade",
      homepage_url: @url,
      source_url: @url,
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env),
      deps: deps(),
      package: package(),
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
    ]
  end

  defp package do
    [
      maintainers: ["Connor Jacobsen"],
      licenses: ["MIT"],
      links: %{github: @url},
      files: ~w(lib) ++ ~w(mix.exs README.md),
    ]
  end
end
