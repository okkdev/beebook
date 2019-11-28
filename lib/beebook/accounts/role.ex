defmodule Beebook.Accounts.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :name, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:role, :name])
    |> validate_required([:role, :name])
    |> unique_constraint(:name)
  end
end
