class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
    @image = @project.images.build
  end

  def create
    @project = Project.new

    images = params[:project][:images_attributes]
    @project.name = params[:project][:name]

    logger.debug("debug\n\n")
    
    images.values.each do |im|
      logger.debug(im)
      img = Image.new(im)
      @project.images << img
    end

    logger.debug("\n\ndebug\n\n")

    @project.save
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
