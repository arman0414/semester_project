defmodule SemesterProjectWeb.EmployeeLive.Index do
  use SemesterProjectWeb, :live_view

  alias SemesterProject.HumanResources
  alias SemesterProject.HumanResources.Employee

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :employees, HumanResources.list_employees())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Employee")
    |> assign(:employee, HumanResources.get_employee!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Employee")
    |> assign(:employee, %Employee{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Employees")
    |> assign(:employee, nil)
  end

  @impl true
  def handle_info({SemesterProjectWeb.EmployeeLive.FormComponent, {:saved, employee}}, socket) do
    {:noreply, stream_insert(socket, :employees, employee)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    employee = HumanResources.get_employee!(id)
    {:ok, _} = HumanResources.delete_employee(employee)

    {:noreply, stream_delete(socket, :employees, employee)}
  end
end
