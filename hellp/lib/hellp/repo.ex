defmodule Hellp.Repo do
  use Ecto.Repo,
    otp_app: :hellp,
    adapter: Ecto.Adapters.Postgres
end
