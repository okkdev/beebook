defmodule Beebook.Library.Links do
  use Ecto.Schema
  import Ecto.Changeset

  schema "link" do
    field :name, :string
    field :priority, :integer
    field :url, :string
    field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(links, attrs) do
    links
    |> cast(attrs, [:name, :url, :priority])
    |> validate_required([:name, :url, :priority])
  end
end
