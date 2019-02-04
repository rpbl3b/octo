defmodule Octo.Repo do
  @moduledoc """
  Split read/write operations across multiple Ecto repos.

  Forwards all write operations to the `master_repo` and all read operations to the `replica_repos`
  """

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      master_repo = Keyword.get(opts, :master_repo)
      replica_repos = Keyword.get(opts, :replica_repos, [master_repo])
      algorithm = Keyword.get(opts, :algorithm, Octo.Algorithms.Random)

      @master_repo master_repo
      @replica_repos replica_repos
      @algorithm algorithm

      def master_repo, do: @master_repo

      def replica_repos, do: @replica_repos

      # write ops
      defdelegate delete!(struct_or_changeset, opts \\ []), to: @master_repo
      defdelegate delete(struct_or_changeset, opts \\ []), to: @master_repo
      defdelegate delete_all(queryable, opts \\ []), to: @master_repo
      defdelegate insert!(struct_or_changeset, opts \\ []), to: @master_repo
      defdelegate insert(struct_or_changeset, opts \\ []), to: @master_repo
      defdelegate insert_all(schema_or_source, entries, opts \\ []), to: @master_repo
      defdelegate insert_or_update!(changeset, opts \\ []), to: @master_repo
      defdelegate insert_or_update(changeset, opts \\ []), to: @master_repo
      defdelegate update!(changeset, opts \\ []), to: @master_repo
      defdelegate update(changeset, opts \\ []), to: @master_repo
      defdelegate update_all(queryable, updates, opts \\ []), to: @master_repo

      # must use master repo for transactions since they may include writes
      defdelegate checkout(function, opts \\ []), to: @master_repo
      defdelegate in_transaction?, to: @master_repo
      defdelegate rollback(value), to: @master_repo
      defdelegate transaction(fun_or_multi, opts \\ []), to: @master_repo

      # read opts
      def aggregate(queryable, aggregate, field, opts \\ []),
        do: replica_repo().aggregate(queryable, aggregate, field, opts)
      def all(queryable, opts \\ []), do: replica_repo().all(queryable, opts)
      def exists?(queryable, opts \\ []),
        do: replica_repo().exists?(queryable, opts)
      def get!(queryable, id, opts \\ []),
        do: replica_repo().get!(queryable, id, opts)
      def get(queryable, id, opts \\ []),
        do: replica_repo().get(queryable, id, opts)
      def get_by!(queryable, clauses, opts \\ []),
        do: replica_repo().get_by!(queryable, clauses, opts)
      def get_by(queryable, clauses, opts \\ []),
        do: replica_repo().get_by(queryable, clauses, opts)
      def load(module_or_map, data),
        do: replica_repo().load(module_or_map, data)
      def one!(queryable, opts \\ []),
        do: replica_repo().one!(queryable, opts)
      def one(queryable, opts \\ []),
        do: replica_repo().one(queryable, opts)
      def preload(structs_or_struct_or_nil, preloads, opts \\ []),
        do: replica_repo().preload(structs_or_struct_or_nil, preloads, opts)
      def stream(queryable, opts \\ []),
        do: stream(queryable, opts)

      # helpers
      defp replica_repo when is_atom(@algorithm), do: @algorithm.get_repo(@replica_repos)
    end
  end
end
