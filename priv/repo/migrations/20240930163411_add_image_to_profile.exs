defmodule Makerprofiles.Repo.Migrations.AddImageToProfile do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      add :profile_image_location, :string
    end
  end
end
