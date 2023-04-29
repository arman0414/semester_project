defmodule SemesterProject.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :EmployeeID, :integer
      add :FirstName, :string
      add :LastName, :string
      add :DateOfHire, :naive_datetime
      add :Department, :string

      timestamps()
    end
  end
end
