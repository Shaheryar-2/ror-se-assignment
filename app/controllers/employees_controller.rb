class EmployeesController < ApplicationController
  before_action :authenticate_user!
  include HandleServiceErrors

  def index
    # Assumption:: The API for employees are not working so I am assuming my responses
    @employees = EmployeeService.get_employees(page: params[:page])
    return handle_error('Unable to retrieve employee data. Please try again later.', root_path) if @employees.nil?
  end

  def show
    @employee = EmployeeService.get_employee(params[:id])
    return handle_error('Unable to retrieve employee details. Please try again later.', employees_path) if @employee.nil?
  end

  def edit
    @employee = EmployeeService.get_employee(params[:id])
    return handle_error('Unable to retrieve employee details for editing. Please try again later.', employees_path) if @employee.nil?
  end

  def create
    employee_params = employee_params_from_request
    @employee = EmployeeService.create_employee(employee_params)
    if @employee.nil?
      handle_error('Failed to create employee. Please try again later.', new_employee_path)
    else
      redirect_to employee_path(@employee.dig("id"))
    end
  end

  def update
    employee_params = employee_params_from_request
    @employee = EmployeeService.update_employee(params[:id], employee_params)
    if @employee.nil?
      handle_error('Failed to update employee. Please try again later.', edit_employee_path(params[:id]))
    else
      redirect_to edit_employee_path(@employee.dig("id"))
    end
  end

  private
    def employee_params_from_request
      params.permit(:name, :position, :date_of_birth, :salary)
    end
end
