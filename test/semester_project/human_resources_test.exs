defmodule SemesterProject.HumanResourcesTest do
  use SemesterProject.DataCase

  alias SemesterProject.HumanResources

  describe "employees" do
    alias SemesterProject.HumanResources.Employee

    import SemesterProject.HumanResourcesFixtures

    @invalid_attrs %{DateOfHire: nil, Department: nil, EmployeeID: nil, FirstName: nil, LastName: nil}

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert HumanResources.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert HumanResources.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      valid_attrs = %{DateOfHire: ~N[2023-04-20 21:23:00], Department: "some Department", EmployeeID: 42, FirstName: "some FirstName", LastName: "some LastName"}

      assert {:ok, %Employee{} = employee} = HumanResources.create_employee(valid_attrs)
      assert employee.DateOfHire == ~N[2023-04-20 21:23:00]
      assert employee.Department == "some Department"
      assert employee.EmployeeID == 42
      assert employee.FirstName == "some FirstName"
      assert employee.LastName == "some LastName"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = HumanResources.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      update_attrs = %{DateOfHire: ~N[2023-04-21 21:23:00], Department: "some updated Department", EmployeeID: 43, FirstName: "some updated FirstName", LastName: "some updated LastName"}

      assert {:ok, %Employee{} = employee} = HumanResources.update_employee(employee, update_attrs)
      assert employee.DateOfHire == ~N[2023-04-21 21:23:00]
      assert employee.Department == "some updated Department"
      assert employee.EmployeeID == 43
      assert employee.FirstName == "some updated FirstName"
      assert employee.LastName == "some updated LastName"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = HumanResources.update_employee(employee, @invalid_attrs)
      assert employee == HumanResources.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = HumanResources.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> HumanResources.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = HumanResources.change_employee(employee)
    end
  end
end
