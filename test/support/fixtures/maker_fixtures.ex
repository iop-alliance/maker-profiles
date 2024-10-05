defmodule Makerprofiles.MakerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Makerprofiles.Maker` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        bio: "some bio",
        name: "some name"
      })
      |> Makerprofiles.Maker.create_profile()

    profile
  end

  @doc """
  Generate a skill.
  """
  def skill_fixture(attrs \\ %{}) do
    {:ok, skill} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Makerprofiles.Maker.create_skill()

    skill
  end
end
