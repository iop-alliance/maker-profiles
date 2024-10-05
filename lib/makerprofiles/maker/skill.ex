defmodule Makerprofiles.Maker.Skill do
  use Ecto.Schema
  import Ecto.Changeset

  alias Makerprofiles.Maker.Profile

  schema "skills" do
    field :name, :string

    many_to_many :profiles, Profile, join_through: "profile_skills"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(skill, attrs) do
    skill
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
