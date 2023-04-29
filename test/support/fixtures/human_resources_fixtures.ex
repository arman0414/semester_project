defmodule SemesterProject.HumanResourcesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SemesterProject.HumanResources` context.
  """

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        DateOfHire: ~N[2023-04-20 21:23:00],
        Department: "some Department",
        EmployeeID: 42,
        FirstName: "some FirstName",
        LastName: "some LastName"
      })
      |> SemesterProject.HumanResources.create_employee()

    employee
  end
end
