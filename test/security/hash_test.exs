defmodule Security.HashTest do
  use ExUnit.Case

  alias Security.Hash

  describe "digest" do
    test "digest/1 generates a hash and returns it" do
      admin_hash = "8C6976E5B5410415BDE908BD4DEE15DFB167A9C873FC4BB8A81F6F2AB448A918"
      assert Hash.digest("admin") == admin_hash
    end

    test "digest/1 returns nil when nothing is passed" do
      assert Hash.digest(nil) == nil
    end
  end
end
