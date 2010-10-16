class ProjectsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!
  before_filter :current_organization
  before_filter :current_project, :only => [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_organization.projects.new(params[:project])
    if @project.save
      flash[:notice] = "Project was successfully created."
    end
    respond_with @project
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:organization])
      flash[:notice] = "Project was successfully updated."
    end
    respond_with @project
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project was successfully deleted."
    respond_with @project
  end

  private
  
  def current_project
    @project = @organization.projects.find(params[:id])
  end

  def current_organization
    @organization ||= begin
      organization = current_user.organizations.find(cookies[:organization])
      cookies[:organization] = organization.id
      organization
    end
  end

end