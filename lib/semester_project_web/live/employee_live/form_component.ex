defmodule SemesterProjectWeb.EmployeeLive.FormComponent do
  use SemesterProjectWeb, :live_component

  alias SemesterProject.HumanResources

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage employee records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="employee-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:EmployeeID]} type="number" label="Employeeid" />
        <.input field={@form[:FirstName]} type="text" label="Firstname" />
        <.input field={@form[:LastName]} type="text" label="Lastname" />
        <.input field={@form[:DateOfHire]} type="datetime-local" label="Dateofhire" />
        <.input field={@form[:Department]} type="text" label="Department" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Employee</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{employee: employee} = assigns, socket) do
    changeset = HumanResources.change_employee(employee)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"employee" => employee_params}, socket) do
    changeset =
      socket.assigns.employee
      |> HumanResources.change_employee(employee_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"employee" => employee_params}, socket) do
    save_employee(socket, socket.assigns.action, employee_params)
  end

  defp save_employee(socket, :edit, employee_params) do
    case HumanResources.update_employee(socket.assigns.employee, employee_params) do
      {:ok, employee} ->
        notify_parent({:saved, employee})

        {:noreply,
         socket
         |> put_flash(:info, "Employee updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_employee(socket, :new, employee_params) do
    case HumanResources.create_employee(employee_params) do
      {:ok, employee} ->
        notify_parent({:saved, employee})

        {:noreply,
         socket
         |> put_flash(:info, "Employee created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
