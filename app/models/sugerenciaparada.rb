class Sugerenciaparada < ActiveRecord::Base
  attr_accessible :latitud, :longitud, :posicion, :sugerencia_id
  belongs_to :sugerencia
end
