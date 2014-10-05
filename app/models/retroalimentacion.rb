class Retroalimentacion < ActiveRecord::Base
  attr_accessible :reservacion_id, :retroaspecto_id, :calificacion
  belongs_to :reservacion
  belongs_to :retroaspecto
end
