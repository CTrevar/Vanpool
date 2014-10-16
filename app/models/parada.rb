class Parada < ActiveRecord::Base
	#belongs_to :ruta
  attr_accessible :estatus, :latitud, :longitud, :nombre, :posicion, :tiempo, :distancia
  has_many :rutas, through: :rutaparadas, source: :ruta
end
