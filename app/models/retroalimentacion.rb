class Retroalimentacion < ActiveRecord::Base
  attr_accessible :reservacion_id, :retroaspecto_id, :calificacion, :aspecto_id, :tipocalificacion_id
  belongs_to :reservacion
  belongs_to :retroaspecto
  belongs_to :tipocalificacion
end
