defmodule PhxEmojiGame.Repo do
  use Ecto.Repo,
    otp_app: :phx_emoji_game,
    adapter: Ecto.Adapters.Postgres
end
