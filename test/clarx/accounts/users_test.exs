defmodule ClarxCore.Accounts.UsersTest do
  use ClarxCore.DataCase

  alias ClarxCore.Accounts.Users

  describe "auth_tokens" do
    alias ClarxCore.Accounts.Users.AuthToken

    import ClarxCore.Accounts.UsersFixtures

    @invalid_attrs %{type: nil, token: nil, expires_at: nil, claims: nil}

    test "list_auth_tokens/0 returns all auth_tokens" do
      auth_token = auth_token_fixture()
      assert Users.list_auth_tokens() == [auth_token]
    end

    test "get_auth_token!/1 returns the auth_token with given id" do
      auth_token = auth_token_fixture()
      assert Users.get_auth_token!(auth_token.id) == auth_token
    end

    test "create_auth_token/1 with valid data creates a auth_token" do
      valid_attrs = %{type: :access, token: "some token", expires_at: ~N[2024-11-01 03:03:00], claims: %{}}

      assert {:ok, %AuthToken{} = auth_token} = Users.create_auth_token(valid_attrs)
      assert auth_token.type == :access
      assert auth_token.token == "some token"
      assert auth_token.expires_at == ~N[2024-11-01 03:03:00]
      assert auth_token.claims == %{}
    end

    test "create_auth_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_auth_token(@invalid_attrs)
    end

    test "update_auth_token/2 with valid data updates the auth_token" do
      auth_token = auth_token_fixture()
      update_attrs = %{type: :refresh, token: "some updated token", expires_at: ~N[2024-11-02 03:03:00], claims: %{}}

      assert {:ok, %AuthToken{} = auth_token} = Users.update_auth_token(auth_token, update_attrs)
      assert auth_token.type == :refresh
      assert auth_token.token == "some updated token"
      assert auth_token.expires_at == ~N[2024-11-02 03:03:00]
      assert auth_token.claims == %{}
    end

    test "update_auth_token/2 with invalid data returns error changeset" do
      auth_token = auth_token_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_auth_token(auth_token, @invalid_attrs)
      assert auth_token == Users.get_auth_token!(auth_token.id)
    end

    test "delete_auth_token/1 deletes the auth_token" do
      auth_token = auth_token_fixture()
      assert {:ok, %AuthToken{}} = Users.delete_auth_token(auth_token)
      assert_raise Ecto.NoResultsError, fn -> Users.get_auth_token!(auth_token.id) end
    end

    test "change_auth_token/1 returns a auth_token changeset" do
      auth_token = auth_token_fixture()
      assert %Ecto.Changeset{} = Users.change_auth_token(auth_token)
    end
  end
end
