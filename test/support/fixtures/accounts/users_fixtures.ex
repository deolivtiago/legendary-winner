defmodule ClarxCore.Accounts.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ClarxCore.Accounts.Users` context.
  """

  @doc """
  Generate a unique auth_token token.
  """
  def unique_auth_token_token, do: "some token#{System.unique_integer([:positive])}"

  @doc """
  Generate a auth_token.
  """
  def auth_token_fixture(attrs \\ %{}) do
    {:ok, auth_token} =
      attrs
      |> Enum.into(%{
        claims: %{},
        expires_at: ~N[2024-11-01 03:03:00],
        token: unique_auth_token_token(),
        type: :access
      })
      |> ClarxCore.Accounts.Users.create_auth_token()

    auth_token
  end
end
