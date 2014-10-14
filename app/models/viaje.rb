class Viaje < ActiveRecord::Base
  belongs_to :ruta
  attr_accessible :estadoviaje_id, :estatus, :fecha, :horainicio, :ruta_id
  
  has_many :reservacions
end
