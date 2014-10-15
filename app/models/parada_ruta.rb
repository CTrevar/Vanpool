class ParadaRuta < ActiveRecord::Base
	belongs_to :ruta
  attr_accessible :posicion, :tiempo, :distancia, :id
  has_many :paradas
end