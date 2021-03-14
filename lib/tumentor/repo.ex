defmodule Tumentor.Repo do
  use Ecto.Repo,
    otp_app: :tumentor,
    adapter: Ecto.Adapters.Postgres
end
