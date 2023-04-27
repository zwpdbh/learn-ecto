import Config

config :friends, Friends.Repo,
  username: "postgres",
  password: "postgres",
  database: "friends_repo",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
