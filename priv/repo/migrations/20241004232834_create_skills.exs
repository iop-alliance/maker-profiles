defmodule Makerprofiles.Repo.Migrations.CreateSkills do
  use Ecto.Migration

  def change do
    create table(:skills) do
      add :name, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:skills, [:name])
  end
end
