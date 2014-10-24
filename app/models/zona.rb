class Zona < ActiveRecord::Base
  belongs_to :ciudad
  has_many :rutas
  attr_accessible :clave, :estauts, :nombre, :id, :ciudad_id
end
