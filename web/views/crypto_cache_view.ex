defmodule Cryptocaching.CryptoCacheView do
  use Cryptocaching.Web, :view

  def render("index.json", %{cryptocaches: cryptocaches}) do
    %{data: render_many(cryptocaches, Cryptocaching.CryptoCacheView, "crypto_cache.json")}
  end

  def render("show.json", %{crypto_cache: crypto_cache}) do
    %{data: render_one(crypto_cache, Cryptocaching.CryptoCacheView, "crypto_cache.json")}
  end

  def render("crypto_cache.json", %{crypto_cache: crypto_cache}) do
    %{id: crypto_cache.id,
      geocache_id: crypto_cache.geocache_id,
      validation_hash: crypto_cache.validation_hash}
  end
end