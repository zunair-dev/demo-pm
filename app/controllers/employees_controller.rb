class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate

  def index
    @tasks = current_user.tasks.searchTask(params[:search]).paginate(page: params[:page], per_page: 4)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/tasks_pdf.html.erb"
      end
    end
  end

  def complete
    @tasks = current_user.tasks.where(status: 'complete').search(params[:search]).paginate(page: params[:page], per_page: 4)
    add_breadcrumbs('Completed Tasks')
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/tasks_pdf.html.erb"
      end
    end
  end

  def tasks
    @tasks = current_user.tasks.paginate(page: params[:page], per_page: 4)
    add_breadcrumbs('Tasks')
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/tasks_pdf.html.erb"
      end
    end
  end

  def projects
    @projects = current_user.projects.paginate(page: params[:page], per_page: 4)
    add_breadcrumbs('All Projects')
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/projects_pdf.html.erb"
      end
    end
  end

  def active_projects
    @projects = current_user.projects.where.not(status: 'complete').paginate(page: params[:page], per_page: 4)
    add_breadcrumbs('Active Projects')
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/projects_pdf.html.erb"
      end
    end
  end

  def completed_projects
    @projects = current_user.projects.where(status: 'complete').paginate(page: params[:page], per_page: 4)
    add_breadcrumbs('Completed Projects')
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/projects_pdf.html.erb"
      end
    end
  end

  def pdf
    @tasks = current_user.tasks.all
    @projects = current_user.projects.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "status report", template: "employees/pdf.html.erb"
      end
    end
  end

  private

  def authenticate
    if current_user.admin?
      flash[:alert] = "You can't switch to employees dashboard!"
      redirect_to root_path
    end
  end
end
