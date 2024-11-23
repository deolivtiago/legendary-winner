defmodule ClarxCore.Accounts.Users.AuthToken do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "auth_tokens" do
    field :type, Ecto.Enum, values: [:access, :refresh]
    field :token, :string
    field :expires_at, :naive_datetime
    field :claims, :map
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(auth_token, attrs) do
    auth_token
    |> cast(attrs, [:type, :token, :expires_at, :claims])
    |> validate_required([:type, :token, :expires_at])
    |> unique_constraint(:token)
  end
end
