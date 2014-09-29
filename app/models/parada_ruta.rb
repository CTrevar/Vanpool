class ParadaRuta < ActiveRecord::Base
	belongs_to :ruta
	has_one :parada
  attr_accessible :distancia, :posicion, :tiempo, :via_puntos
end
