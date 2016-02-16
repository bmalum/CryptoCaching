defmodule Cryptocaching.CryptoCacheController do
  use Cryptocaching.Web, :controller

  alias Cryptocaching.CryptoCache

  plug :scrub_params, "crypto_cache" when action in [:create, :update]

  def index(conn, _params) do
    cryptocaches = Repo.all(CryptoCache)
    render(conn, "index.json", cryptocaches: cryptocaches)
  end

  def create(conn, %{"crypto_cache" => crypto_cache_params}) do
    changeset = CryptoCache.changeset(%CryptoCache{}, crypto_cache_params)

    case Repo.insert(changeset) do
      {:ok, crypto_cache} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", crypto_cache_path(conn, :show, crypto_cache))
        |> render("show.json", crypto_cache: crypto_cache)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Cryptocaching.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    crypto_cache = Repo.get!(CryptoCache, id)
    render(conn, "show.json", crypto_cache: crypto_cache)
  end

  def update(conn, %{"id" => id, "crypto_cache" => crypto_cache_params}) do
    crypto_cache = Repo.get!(CryptoCache, id)
    changeset = CryptoCache.changeset(crypto_cache, crypto_cache_params)

    case Repo.update(changeset) do
      {:ok, crypto_cache} ->
        render(conn, "show.json", crypto_cache: crypto_cache)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Cryptocaching.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    crypto_cache = Repo.get!(CryptoCache, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(crypto_cache)

    send_resp(conn, :no_content, "")
  end
end
