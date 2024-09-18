class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @employees = EmployeesApiService.get_all(params[:page])
  end

  def edit
    @employee = EmployeesApiService.get_employee(params[:id])
  end

  def show
    @employee = EmployeesApiService.get_employee(params[:id])
  end

  def create
    @employee = EmployeesApiService.create_employee(employee_params)
    redirect_to employee_path(@employee['id'])
  end

  def update
    @employee = EmployeesApiService.update_employee(params[:id], employee_params)
    redirect_to edit_employee_path(@employee['id'])
  end

  private

  def employee_params
    params.permit(:name, :position, :date_of_birth, :salary)
  end
end
