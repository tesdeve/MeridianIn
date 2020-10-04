class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
 skip_forgery_protection
 
  def import
    Employee.import(params[:file])
    redirect_to root_url, notice: "Employees imported."
  end

  def index
    total_production
    @employees = Employee.all.order(:surname)
    @employee = Employee.new
    respond_to do |format|
      format.html
      #format.csv { render text: @employees.to_csv }
      format.csv { send_data @employees.to_csv }
      format.xls { send_data @employees.to_csv(col_sep: "\t") }
    end
  end

  def search 
    @employees = Employee.where("surname ILIKE ?", "%" + params[:q] + "%" )
  end 

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.js
    end
  end
  

  # GET /employees/1/edit
  def edit
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.js
    end
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employees, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
        format.js
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employees_path, notice: 'Employee was successfully updated!' }
        format.json { render :show, status: :ok, location: @employee }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def total_production
    @employees = Employee.all
    @total_production =  @employees.where({role: "BOOKED", clocked_in: true}).count + 
    @employees.where({role: "REPLENISHER", clocked_in: true}).count + 
    @employees.where({role: "BOOKED NEW", clocked_in: true}).count
  end

  def remove_all
     Employee.delete_all
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employees were successfully removed' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:name, :surname, :role, :payroll, :telephone, :clocked_in, :status, :clocked_at)
    end
end
