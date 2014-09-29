class RutasController < ApplicationController
	def index
		@rutas = Ruta.all
	end

	def new
		@ruta = Ruta.new
		@parada = Parada.new
	end

	def create
		@ruta = Ruta.new(params[:ruta])
		@parada = Parada.new(params[:parada])
		@viaje = Viaje.new(params[:viaje])

		@ruta.save
		@parada.save
		@viaje.save
		
		redirect_to rutas_path
	end

	def show
		@ruta = Ruta.find(params[:id])
	end

	
	
end
