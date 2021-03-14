defmodule Tumentor.Repo.Migrations.CreateMentors do
  use Ecto.Migration

  def change do
    create table(:mentors) do
      add :name, :string
      add :topics, :map
      add :github_url, :string
      add :schedule_url, :string

      timestamps()
    end

  end
end
