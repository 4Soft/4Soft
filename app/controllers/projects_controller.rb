class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @projects = Project.find(params[:id])
  end

  def new
    @project = Project.new
    @image = @project.images.build
  end

  def create
    if Project.create(params[:project][:name], params[:project][:description],
     params[:project][:cover], params[:project][:images_attributes])
      redirect_to projects_path, 
        :notice => 'Novo projeto adicionado com sucesso'
    else
      flash[:notice] = "Algum erro aconteceu"
      render :action => :new
    end
    
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
