defmodule ClarxCore do
  @moduledoc """
  ClarxCore keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.

  This can be used in your application as:
      use ClarxCore, :schema
  """

  def schema do
    quote do
      use Ecto.Schema

      import Ecto.Changeset

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts type: :utc_datetime

      def changeset, do: %{change(struct(__MODULE__)) | valid?: false}
      def changeset(schema) when is_struct(schema, __MODULE__), do: change(schema)

      defp cast(schema, attrs) when is_non_struct_map(schema) or is_list(schema) do
        %{Goal.build_changeset(schema, attrs) | valid?: false}
      end
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
