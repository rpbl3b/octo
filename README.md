# Octo

[![Hex.pm](https://img.shields.io/hexpm/v/octo.svg)](https://hex.pm/packages/octo) [![API Docs](https://img.shields.io/badge/api-docs-yellow.svg?style=flat)](http://hexdocs.pm/octo/) [![Build Status](https://travis-ci.org/connorjacobsen/octo.svg?branch=master)](https://travis-ci.org/connorjacobsen/octo)

Octo uses the `facade` pattern to distribute reads and writes to different [ecto](https://github.com/elixir-ecto/ecto) 3 repos.

Currently, Octo does not integrate with `ecto_sql` at all and it is suggested to run all of your migrations against your master repo.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `octo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:octo, "~> 0.1.1"}
  ]
end
```

## Usage

A simple setup might look something like this:

```elixir
# my_app/write_repo.ex
defmodule MyApp.WriteRepo do
  use Ecto.Repo, otp_app: :my_app
end

# my_app/read_one_repo.ex
defmodule MyApp.ReadOneRepo do
  use Ecto.Repo, otp_app: :my_app
end

# my_app/read_two_repo.ex
defmodule MyApp.ReadTwoRepo do
  use Ecto.Repo, otp_app: :my_app
end

# my_app/repo.ex
defmodule MyApp.Repo do
  use Octo.Repo,
    master_repo: MyApp.WriteRepo,
    replica_repos: [MyApp.ReadOneRepo, MyApp.ReadTwoRepo],
    algorithm: Octo.Algorithms.RoundRobin
end
```

## Custom Algorithms

By default, the replica repo to use is chosen randomly, but you can define your own selection algorithms by implementing the `Octo.Algorithm` behaviour.

```elixir
defmodule MyApp.MyAlgorithm do
  @behaviour Octo.Algorithm

  def get_repo(replica_repos) do
    # Your code here...
  end
end
```

Configuration is simple:

```elixir
defmodule MyApp.Repo do
  use Octo.Repo,
    master_repo: MyApp.WriteRepo,
    replica_repos: [MyApp.ReadOneRepo, MyApp.ReadTwoRepo],
    algorithm: MyApp.MyAlgorithm
```
