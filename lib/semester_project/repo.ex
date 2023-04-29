defmodule SemesterProject.Repo do
  use Ecto.Repo,
    otp_app: :semester_project,
    adapter: Ecto.Adapters.Postgres
end
