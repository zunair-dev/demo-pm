class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :add_index_breadcrumb, only: [:show, :edit, :new]

  # GET projects/1/tasks
  def index
    @tasks = @project.tasks
    add_breadcrumbs('All Tasks')
  end

  # GET projects/1/tasks/1
  def show
    add_breadcrumbs(@task.name)
  end

  # GET projects/1/tasks/new
  def new
    @task = @project.tasks.build
    add_breadcrumbs('New Task')
  end

  # GET projects/1/tasks/1/edit
  def edit
    add_breadcrumbs('Edit')
  end

  # POST projects/1/tasks
  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      redirect_to(@task.project)
    else
      render action: 'new'
    end
  end

  def assign
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  # PUT projects/1/tasks/1
  def update
    if @task.update(task_params)
      if current_user.admin == true
        redirect_to(@task.project)
      else
        redirect_to(employees_index_path)
      end
    else
      render action: 'edit'
    end
  end

  # DELETE projects/1/tasks/1
  def destroy
    @task.destroy

    redirect_to @project
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :status, :project_id, :hours_worked, :hours, :user_id, :starting_date, :ending_date)
    end

    def add_index_breadcrumb
      add_breadcrumbs('Project', project_path(@project))
    end
end
