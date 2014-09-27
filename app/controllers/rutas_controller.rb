class RutasController < ApplicationController
	def index
		@rutas = Ruta.all
	end

	def new
	end

	def create
		@ruta = Ruta.new(params[:ruta])
		@ruta.save
		redirect_to @ruta
	end

	def show
		@ruta = Ruta.find(params[:id])
	end

	
	
end
