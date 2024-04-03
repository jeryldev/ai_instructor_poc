defmodule AiInstructorPoc.Repo do
  use Ecto.Repo,
    otp_app: :ai_instructor_poc,
    adapter: Ecto.Adapters.Postgres
end
