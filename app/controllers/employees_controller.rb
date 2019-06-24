class EmployeesController < ApplicationController
  def Index
    @employees = Employees.all
  end

  def create
    @company = Company.find(params[:company_id])
    @employee = Employee.new(employee_params)
    @employee.company = @company
    @employee.area = Area.find(params[:employee][:area])
    @employee.save
    flash[:errors] = @employee.errors
    redirect_to company_url({id: @company, error: @employee.errors.size})
  end

  def destroy
    @company = Company.find(params[:company_id])
    @employee = Employee.find(params[:id])
    @employee.delete
    redirect_to company_path(@company)
  end

  private
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email)
  end
end
