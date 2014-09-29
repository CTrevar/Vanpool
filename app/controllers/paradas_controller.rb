class ParadasController < ApplicationController
	def new
		@parada = Parada.new
	end

	def create
		@parada = Parada.new(params[:van])
		@parada.estatus= true

		@parada.save

		if @parada.save
			redirect_to @parada
		else
			render 'new'
		end
		
		
	end

	def show
		@parada = Parada.find(params[:id])
	end

	def index
		@paradas = Parada.all
	end

	def destroy
		@parada = Parada.find (params[:id])
		@parada.destroy
		redirect_to paradas_path
	end

	def edit
		@parada = Parada.find(params[:id])
	end

	def update
		@parada = Parada.find(params[:id])
		if @parada.update_attributes(params[:van])
			redirect_to @parada
		else
			render 'edit'
		end
	end
end
