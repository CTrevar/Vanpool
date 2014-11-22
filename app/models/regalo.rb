class Regalo < ActiveRecord::Base
  attr_accessible :nombre, :descripcion, :perfil_id, :medalla_id, :estatus
  belongs_to :perfil
  belongs_to :medalla
end