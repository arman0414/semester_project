defmodule SemesterProject.HumanResources.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :DateOfHire, :naive_datetime
    field :Department, :string
    field :EmployeeID, :integer
    field :FirstName, :string
    field :LastName, :string

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:EmployeeID, :FirstName, :LastName, :DateOfHire, :Department])
    |> validate_required([:EmployeeID, :FirstName, :LastName, :DateOfHire, :Department])
  end
end
