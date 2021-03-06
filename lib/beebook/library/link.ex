defmodule Beebook.Library.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :name, :string
    field :priority, :integer
    field :url, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:name, :url, :priority, :user_id])
    |> validate_required([:name, :url, :priority, :user_id])
    |> validate_length(:url, min: 1, max: 255)
    |> validate_length(:name, min: 1, max: 40)
    |> foreign_key_constraint(:user_id)
  end
end
