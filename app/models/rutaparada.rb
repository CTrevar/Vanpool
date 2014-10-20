class Rutaparada < ActiveRecord::Base
  attr_accessible :distancia, :parada_id, :posicion, :ruta_id, :tiempo, :id
  belongs_to :ruta
  belongs_to :parada
end
