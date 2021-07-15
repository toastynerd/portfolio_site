class ProjectsController < ApplicationController
  before_action :require_logged_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    puts project_params
    @project = Project.new(project_params)
    @project.technologies = params[:project][:technologies].split(',')
    if @project.save
      redirect_to projects_path, notice: "Successfully create a project"
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @project.technologies = @project.technologies.join(', ')
  end

  def update
    @project = Project.find(params[:id])
    @project.technologies = params[:project][:technologies].split(', ')
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])

    @project.destroy
    redirect_to projects_path, notice: "Project successfully deleted"
  end

  private
  def project_params
    params.require(:project).permit(:title, :description, links_attributes: [:body, :icon_url])
  end
end
