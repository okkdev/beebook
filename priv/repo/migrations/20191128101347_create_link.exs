defmodule Beebook.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:link) do
      add :name, :string
      add :url, :string
      add :priority, :integer
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:link, [:author_id])
  end
end
