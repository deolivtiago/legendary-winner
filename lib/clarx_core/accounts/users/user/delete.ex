defmodule ClarxCore.Accounts.Users.User.Delete do
  @moduledoc false

  alias ClarxCore.Accounts.Users.User
  alias ClarxCore.Repo

  @opts [stale_error_field: :id, stale_error_message: "not found"]

  @doc false
  def call(%User{} = user), do: Repo.delete(user, @opts)
end
