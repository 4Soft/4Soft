class ImagesController < ApplicationController
	def index
	end

	def create
		@image = Image.new(params[:image])
		@image.save!

		redirect_to images_path
	end

	def show
		@image = Image.first
	end
end
