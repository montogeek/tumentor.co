defmodule Tumentor.Mentors.Mentor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mentors" do
    field :github_url, :string
    field :name, :string
    field :schedule_url, :string
    field :topics, :map

    timestamps()
  end

  @doc false
  def changeset(mentor, attrs) do
    mentor
    |> cast(attrs, [:name, :topics, :github_url, :schedule_url])
    |> validate_required([:name, :topics, :github_url, :schedule_url])
  end
end
