class Viaje < ActiveRecord::Base
  attr_accessible :estadoviaje_id, :estatus, :fecha, :horainicio, :ruta_id
  belongs_to :ruta
  has_many :reservacions
end
