class VansController < ApplicationController
	def new
		@van = Van.new
	end

	def create
		@van = Van.new(params[:van])
		@van.estatus= true
		@van.activa = true

		@van.save

		if @van.save
			redirect_to @van
		else
			render 'new'
		end
		
		
	end

	def show
		@van = Van.find(params[:id])
	end

	def index
		@vans = Van.all
	end

	def destroy
		@van = Van.find (params[:id])
		@van.destroy
		redirect_to vans_path
	end

	def edit
		@van = Van.find(params[:id])
	end

	def update
		@van = Van.find(params[:id])
		if @van.update_attributes(params[:van])
			redirect_to @van
		else
			render 'edit'
		end
	end
end
