class Sugerenciaparada < ActiveRecord::Base
  attr_accessible :latitud, :longitud, :posicion, :sugerencia_id, :nombre
  belongs_to :sugerencia
  validates_presence_of :latitud, :posicion, :longitud
end
