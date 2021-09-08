class EmployeesController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks = current_user.tasks.all
  end
end
