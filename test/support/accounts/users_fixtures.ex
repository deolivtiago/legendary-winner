defmodule ClarxCore.Accounts.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ClarxCore.Accounts.Users` context.
  """
  alias ClarxCore.Accounts.Users.User
  alias ClarxCore.Repo

  @doc """
  Generate fake user attrs
    ## Examples
      iex> user_attrs(%{field: value})
      %{field: value, ...}
  """
  def user_attrs(attrs \\ %{}) do
    otp_secret = NimbleTOTP.secret()

    Map.new()
    |> Map.put(:id, Faker.UUID.v4())
    |> Map.put(:full_name, Faker.Person.name())
    |> Map.put(:email, Faker.Internet.email())
    |> Map.put(:password, "P455w0rd?")
    |> Map.put(:avatar_url, Faker.Internet.image_url())
    |> Map.put(:role, :user)
    |> Map.put(:verified?, true)
    |> Map.put(:otp_secret, otp_secret)
    |> Map.put(:code, NimbleTOTP.verification_code(otp_secret, period: 300))
    |> Map.put(:inserted_at, DateTime.add(DateTime.utc_now(:second), Enum.random(-90..-1), :day))
    |> Map.put(:updated_at, DateTime.add(DateTime.utc_now(:second), Enum.random(-90..-1), :day))
    |> Map.merge(attrs)
  end

  @doc """
  Builds a fake user
    ## Examples
      iex> build_user(%{field: value})
      %User{field: value, ...}
  """
  def build_user(attrs \\ %{}) do
    attrs
    |> user_attrs()
    |> User.changeset()
    |> Ecto.Changeset.apply_action!(nil)
  end

  @doc """
  Inserts a fake user
    ## Examples
      iex> insert_user(%{field: value})
      %User{field: value, ...}
  """
  def insert_user(attrs \\ %{}) do
    attrs
    |> user_attrs()
    |> User.changeset()
    |> Repo.insert!()
  end
end
