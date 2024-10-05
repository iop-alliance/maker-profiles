defmodule Makerprofiles.MakerTest do
  use Makerprofiles.DataCase

  alias Makerprofiles.Maker

  describe "profiles" do
    alias Makerprofiles.Maker.Profile

    import Makerprofiles.MakerFixtures

    @invalid_attrs %{bio: nil, name: nil}

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Maker.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Maker.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      valid_attrs = %{bio: "some bio", name: "some name"}

      assert {:ok, %Profile{} = profile} = Maker.create_profile(valid_attrs)
      assert profile.bio == "some bio"
      assert profile.name == "some name"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Maker.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      update_attrs = %{bio: "some updated bio", name: "some updated name"}

      assert {:ok, %Profile{} = profile} = Maker.update_profile(profile, update_attrs)
      assert profile.bio == "some updated bio"
      assert profile.name == "some updated name"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Maker.update_profile(profile, @invalid_attrs)
      assert profile == Maker.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Maker.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Maker.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Maker.change_profile(profile)
    end
  end

  describe "skills" do
    alias Makerprofiles.Maker.Skill

    import Makerprofiles.MakerFixtures

    @invalid_attrs %{name: nil}

    test "list_skills/0 returns all skills" do
      skill = skill_fixture()
      assert Maker.list_skills() == [skill]
    end

    test "get_skill!/1 returns the skill with given id" do
      skill = skill_fixture()
      assert Maker.get_skill!(skill.id) == skill
    end

    test "create_skill/1 with valid data creates a skill" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Skill{} = skill} = Maker.create_skill(valid_attrs)
      assert skill.name == "some name"
    end

    test "create_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Maker.create_skill(@invalid_attrs)
    end

    test "update_skill/2 with valid data updates the skill" do
      skill = skill_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Skill{} = skill} = Maker.update_skill(skill, update_attrs)
      assert skill.name == "some updated name"
    end

    test "update_skill/2 with invalid data returns error changeset" do
      skill = skill_fixture()
      assert {:error, %Ecto.Changeset{}} = Maker.update_skill(skill, @invalid_attrs)
      assert skill == Maker.get_skill!(skill.id)
    end

    test "delete_skill/1 deletes the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{}} = Maker.delete_skill(skill)
      assert_raise Ecto.NoResultsError, fn -> Maker.get_skill!(skill.id) end
    end

    test "change_skill/1 returns a skill changeset" do
      skill = skill_fixture()
      assert %Ecto.Changeset{} = Maker.change_skill(skill)
    end
  end
end
