defmodule Makerprofiles.Maker.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  alias Makerprofiles.Maker.Skill

  schema "profiles" do
    field :bio, :string
    field :name, :string
    field :profile_image_location, :string, default: ""

    belongs_to :user, Makerprofiles.Accounts.User

    many_to_many :skills, Skill, join_through: "profile_skills"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:name, :bio, :profile_image_location, :user_id])
    |> validate_required([:name, :user_id])
    |> foreign_key_constraint(:user_id) # Enforce the foreign key constraint
  end
end
