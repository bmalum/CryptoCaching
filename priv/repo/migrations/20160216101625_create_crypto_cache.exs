defmodule Cryptocaching.Repo.Migrations.CreateCryptoCache do
  use Ecto.Migration

  def change do
    create table(:cryptocaches) do
      add :geocache_id, :string
      add :validation_hash, :string

      timestamps
    end

  end
end
