defmodule TinyNote.Repo do
  use Ecto.Repo,
    otp_app: :tiny_note,
    adapter: Ecto.Adapters.Postgres
end
