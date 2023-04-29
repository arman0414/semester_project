defmodule SemesterProjectWeb.EmployeeApiJSON do
    def index(%{employees: employees}) do
        %{data:
            for(employee <- employees) do
            %{employee: employee."EmployeeID",
            firstname: employee."FirstName",
            lastname: employee."LastName",
            Date: employee."DateOfHire"}
            
            
            
              
            end
        }
    end
end