defmodule Octo.RepoTest do
  use ExUnit.Case

  require Octo.TestRepo, as: TestRepoOne
  require Octo.TestRepo, as: TestRepoTwo
  require Octo.TestRepo, as: TestRepoThree

  defmodule TestOctoSimple do
    use Octo.Repo, master_repo: TestRepoOne
  end

  defmodule TestOcto do
    use Octo.Repo,
      master_repo: TestRepoOne,
      replica_repos: [TestRepoTwo, TestRepoThree]
  end

  describe "master_repo/0" do
    test "returns master_repo" do
      assert TestRepoOne == TestOcto.master_repo()
      assert TestRepoOne == TestOctoSimple.master_repo()
    end
  end

  describe "replica_repos/0" do
    test "returns replica_repos when configured" do
      assert [TestRepoTwo, TestRepoThree] == TestOcto.replica_repos()
    end

    test "returns master_repo by default" do
      assert [TestRepoOne] == TestOctoSimple.replica_repos()
    end
  end
end
