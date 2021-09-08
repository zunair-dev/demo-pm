class EmployeesController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks = current_user.tasks.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/index.html.erb"   # Excluding ".pdf" extension.
      end
    end
  end
end
