defmodule Cryptocaching.CryptoCacheTest do
  use Cryptocaching.ModelCase

  alias Cryptocaching.CryptoCache

  @valid_attrs %{geocache_id: "some content", validation_hash: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CryptoCache.changeset(%CryptoCache{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CryptoCache.changeset(%CryptoCache{}, @invalid_attrs)
    refute changeset.valid?
  end
end
