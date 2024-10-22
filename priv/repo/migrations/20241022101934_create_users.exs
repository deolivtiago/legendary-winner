defmodule ClarxCore.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :full_name, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false

      add :avatar_url, :string, default: ""
      add :role, :string, null: false

      add :otp_secret, :binary, null: false
      add :is_verified, :boolean, default: false

      timestamps(type: :timestamptz)
    end

    create unique_index(:users, [:email])
  end
end