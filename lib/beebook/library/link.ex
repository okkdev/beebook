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
    |> cast(attrs, [:name, :url, :priority])
    |> validate_required([:name, :url, :priority])
  end
end
