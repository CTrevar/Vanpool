class Parada < ActiveRecord::Base
	belongs_to :ruta
  attr_accessible :estatus, :latitud, :longitud, :nombre, :posicion, :tiempo, :distancia
end
