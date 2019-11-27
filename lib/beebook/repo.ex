defmodule Beebook.Repo do
  use Ecto.Repo,
    otp_app: :beebook,
    adapter: Ecto.Adapters.Postgres
end
