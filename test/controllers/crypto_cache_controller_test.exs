defmodule Cryptocaching.CryptoCacheControllerTest do
  use Cryptocaching.ConnCase

  alias Cryptocaching.CryptoCache
  @valid_attrs %{geocache_id: "some content", validation_hash: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, crypto_cache_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    crypto_cache = Repo.insert! %CryptoCache{}
    conn = get conn, crypto_cache_path(conn, :show, crypto_cache)
    assert json_response(conn, 200)["data"] == %{"id" => crypto_cache.id,
      "geocache_id" => crypto_cache.geocache_id,
      "validation_hash" => crypto_cache.validation_hash}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, crypto_cache_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, crypto_cache_path(conn, :create), crypto_cache: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(CryptoCache, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, crypto_cache_path(conn, :create), crypto_cache: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    crypto_cache = Repo.insert! %CryptoCache{}
    conn = put conn, crypto_cache_path(conn, :update, crypto_cache), crypto_cache: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(CryptoCache, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    crypto_cache = Repo.insert! %CryptoCache{}
    conn = put conn, crypto_cache_path(conn, :update, crypto_cache), crypto_cache: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    crypto_cache = Repo.insert! %CryptoCache{}
    conn = delete conn, crypto_cache_path(conn, :delete, crypto_cache)
    assert response(conn, 204)
    refute Repo.get(CryptoCache, crypto_cache.id)
  end
end
