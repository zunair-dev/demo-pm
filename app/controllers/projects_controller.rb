class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :add_index_breadcrumb, only: [:show, :edit, :new]
  before_action :check_admin

  # GET /projects or /projects.json
  def index
    # flash.now[:alert] = "We have exactly"
    @projects = current_user.self_projects.paginate(page: params[:page], per_page: 4) if current_user.admin?
  end

  def all
    @projects = Project.all.paginate(page: params[:page], per_page: 4)
    add_breadcrumbs('All Projects')
  end

  # GET /projects/1 or /projects/1.json
  def show
    @task = @project.tasks.build
    add_breadcrumbs(@project.name)
  end

  # GET /projects/new
  def new
    @project = current_user.self_projects.build
    add_breadcrumbs('New')
  end

  # GET /projects/1/edit
  def edit
    add_breadcrumbs('Edit')
  end

  # POST /projects or /projects.json
  def create
    @project = current_user.self_projects.build(project_params)

    respond_to do |format|
      if @project.save
        @project.users << User.find(params[:project][:emp]) unless params[:project][:emp].blank?
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    @project.users << User.find(params[:project][:emp]) unless params[:project][:emp].blank?
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :hours, :cost, :status, :starting_date, :ending_date)
    end

    def add_index_breadcrumb
      add_breadcrumbs('All Projects', all_projects_path)
    end

    def check_admin
      if current_user.admin == false
        redirect_to employees_index_path
      end
    end
end
