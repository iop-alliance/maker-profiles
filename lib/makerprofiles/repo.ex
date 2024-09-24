defmodule Makerprofiles.Repo do
  use Ecto.Repo,
    otp_app: :makerprofiles,
    adapter: Ecto.Adapters.Postgres
end
