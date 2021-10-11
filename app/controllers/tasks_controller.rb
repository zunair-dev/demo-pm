class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :add_index_breadcrumb, only: [:show, :edit, :new]
  before_action :authenticate, except: [:show, :edit, :update]
  before_action :verify_user, only: [:show, :edit, :update]

  # GET projects/1/tasks
  def index
    @tasks = @project.tasks.order(id: :asc)
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
    respond_to do |format|
      if @task.save
        UserMailer.with(user: @user, task: @task).send_task_alert.deliver_later
        format.html { redirect_to @task.project, notice: "Task was successfully created." }
      else
        format.html { render action: 'new', alert: "Task wasn't successfully created." }
      end
    end
  end

  def assign
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  # PUT projects/1/tasks/1
  def update
    Task.update_status(params, @task)       # to update tasks status
    Task.add_logs(params, @task)
    respond_to do |format|
      if @task.update(task_params)
        # to update projects status
        if @task.status == "complete"
          if Project.check_whole_status(@task.project)
            @task.project.status = 1
          else
            @task.project.status = 2
          end
        else
          @task.project.status = 0
        end
        @task.project.save

        if params[:task][:user_id].present?
          @user = User.find(@task.user_id)
          UserMailer.with(user: @user, task: @task).send_task_alert.deliver_later
        end
        if current_user.admin == true
          format.html { redirect_to @task.project, notice: "Task was successfully updated." }
        else
          format.html { redirect_to employees_path, notice: "Task was successfully updated." }
        end
      else
        render action: 'edit'
      end
    end
  end

  # DELETE projects/1/tasks/1
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @project, alert: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
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

  def authenticate
    authorize Task
  end

  def verify_user
    unless @task.user == current_user || current_user.admin?
      flash[:alert] = "You're not allowed to do this!"
      redirect_to root_path
    end
  end
end
