defmodule ClarxCore.Accounts.Users.User.Confirm do
  @moduledoc false
  use ClarxCore, :schema

  alias ClarxCore.Accounts.Users.User
  alias ClarxCore.Repo

  @doc false
  def call(%User{} = user, code) when is_binary(code) do
    if NimbleTOTP.valid?(user.otp_secret, code, period: 300) do
      user
      |> User.changeset(%{verified?: true})
      |> Repo.update!()
      |> then(&{:ok, &1})
    else
      user
      |> change(%{code: code})
      |> add_error(:code, "is invalid")
      |> then(&{:error, &1})
    end
  end
end
