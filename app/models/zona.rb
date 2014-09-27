class Zona < ActiveRecord::Base
  belongs_to :ciudad
  attr_accessible :clave, :estauts, :nombre
end
