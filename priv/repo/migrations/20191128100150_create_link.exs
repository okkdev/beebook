defmodule Beebook.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:link) do
      add :name, :string
      add :url, :string
      add :priority, :integer

      timestamps()
    end

  end
end
