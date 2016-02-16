defmodule Cryptocaching.CryptoCache do
  use Cryptocaching.Web, :model

  #before_insert :generate_validation_hash

  schema "cryptocaches" do
    field :geocache_id, :string
    field :validation_hash, :string

    timestamps
  end

  @required_fields ~w(geocache_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """

  def generate_validation_hash(changeset) do
    sec_hash = :crypto.strong_rand_bytes(10) |> Base.encode32(case: :upper)
    changeset |>
      Ecto.Changeset.put_change(:validation_hash, sec_hash)
  end 

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> generate_validation_hash
  end
end
