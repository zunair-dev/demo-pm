class EmployeesController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.admin?
      redirect_to root_path
    else
      @tasks = current_user.tasks.where.not(status: 'complete')
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "status report", template: "employees/pdf.html.erb"   # Excluding ".pdf" extension.
        end
      end
    end
  end

  def complete
    if current_user.admin?
      redirect_to root_path
    else
      @tasks = current_user.tasks.where(status: 'complete')
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "status report", template: "employees/pdf.html.erb"   # Excluding ".pdf" extension.
        end
      end
    end
  end

  def pdf
    @tasks = current_user.tasks.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/pdf.html.erb"   # Excluding ".pdf" extension.
      end
    end
  end
end
