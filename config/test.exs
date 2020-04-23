use Mix.Config

# Configure your database
config :study_manager, StudyManager.Repo,
  username: "study_manager",
  password: "letmein",
  database: "study_manager_test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :study_manager, StudyManagerWeb.Endpoint,
  http: [port: 4002],
  server: false

# server: true          Makes the endpoint starts when running tests
# code_reloader: false  No need, and massively slows-down tests on non-Linux
config :study_manager, MocksWeb.Endpoint,
  secret_key_base: "hvuQJYPxR39qidqDnP6FhmurG0FMDWCVz4S4JQdys3npgKHZ32ulgYVyM/8Nff2Z",
  http: [port: 4001],
  debug_errors: true,
  code_reloader: false,
  server: true

# Print only warnings and errors during test
config :logger, level: :warn
