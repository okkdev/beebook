defmodule Beebook.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:link) do
      add :name, :string
      add :url, :string
      add :priority, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:link, [:user_id])
  end
end
