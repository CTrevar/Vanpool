class RutasController < ApplicationController
	def index
		@rutas = Ruta.all
	end

	def new
		@ruta = Ruta.new
		@parada = Parada.new
		@ruta.viajes.build
		@ruta.paradas.build
		@van= Van.new
		@ruta.build_frecuencia
	end

	def create
		@ruta = Ruta.new(params[:ruta])
		@ruta.estatus = true

		
		@viajes = @ruta.viajes

		@viajes.each do|viaje|
		  viaje.estadoviaje_id=1
		  viaje.estatus = true
		end

		


		@ruta.save
		#@viaje.save

		redirect_to rutas_path
	end

	def show
		@ruta = Ruta.find(params[:id])
	end

	
	
end
