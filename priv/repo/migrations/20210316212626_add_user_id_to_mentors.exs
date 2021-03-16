defmodule Tumentor.Repo.Migrations.AddUserIdToMentors do
  use Ecto.Migration

  def change do
    alter table(:mentors) do
      add :user_id, references(:users, on_delete: :delete_all), null: true
    end
  end
end
