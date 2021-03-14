defmodule Tumentor.MentorsTest do
  use Tumentor.DataCase

  alias Tumentor.Mentors

  describe "mentors" do
    alias Tumentor.Mentors.Mentor

    @valid_attrs %{github_url: "some github_url", name: "some name", schedule_url: "some schedule_url", topics: %{}}
    @update_attrs %{github_url: "some updated github_url", name: "some updated name", schedule_url: "some updated schedule_url", topics: %{}}
    @invalid_attrs %{github_url: nil, name: nil, schedule_url: nil, topics: nil}

    def mentor_fixture(attrs \\ %{}) do
      {:ok, mentor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mentors.create_mentor()

      mentor
    end

    test "list_mentors/0 returns all mentors" do
      mentor = mentor_fixture()
      assert Mentors.list_mentors() == [mentor]
    end

    test "get_mentor!/1 returns the mentor with given id" do
      mentor = mentor_fixture()
      assert Mentors.get_mentor!(mentor.id) == mentor
    end

    test "create_mentor/1 with valid data creates a mentor" do
      assert {:ok, %Mentor{} = mentor} = Mentors.create_mentor(@valid_attrs)
      assert mentor.github_url == "some github_url"
      assert mentor.name == "some name"
      assert mentor.schedule_url == "some schedule_url"
      assert mentor.topics == %{}
    end

    test "create_mentor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mentors.create_mentor(@invalid_attrs)
    end

    test "update_mentor/2 with valid data updates the mentor" do
      mentor = mentor_fixture()
      assert {:ok, %Mentor{} = mentor} = Mentors.update_mentor(mentor, @update_attrs)
      assert mentor.github_url == "some updated github_url"
      assert mentor.name == "some updated name"
      assert mentor.schedule_url == "some updated schedule_url"
      assert mentor.topics == %{}
    end

    test "update_mentor/2 with invalid data returns error changeset" do
      mentor = mentor_fixture()
      assert {:error, %Ecto.Changeset{}} = Mentors.update_mentor(mentor, @invalid_attrs)
      assert mentor == Mentors.get_mentor!(mentor.id)
    end

    test "delete_mentor/1 deletes the mentor" do
      mentor = mentor_fixture()
      assert {:ok, %Mentor{}} = Mentors.delete_mentor(mentor)
      assert_raise Ecto.NoResultsError, fn -> Mentors.get_mentor!(mentor.id) end
    end

    test "change_mentor/1 returns a mentor changeset" do
      mentor = mentor_fixture()
      assert %Ecto.Changeset{} = Mentors.change_mentor(mentor)
    end
  end
end
