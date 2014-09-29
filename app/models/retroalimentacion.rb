class Retroalimentacion < ActiveRecord::Base
  attr_accessible :estatus, :reservacion_id
  belongs_to :reservacion
end
