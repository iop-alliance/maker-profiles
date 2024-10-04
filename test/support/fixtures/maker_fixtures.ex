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
end
