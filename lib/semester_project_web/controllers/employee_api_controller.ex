defmodule SemesterProjectWeb.EmployeeApiController do
    alias SemesterProject.HumanResources
 use SemesterProjectWeb, :controller
    def index(conn, _params) do
      employees = HumanResources.list_employees()
      render(conn,:index,employees: employees)
    end
end