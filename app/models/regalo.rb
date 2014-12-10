class Regalo < ActiveRecord::Base
  attr_accessible :nombre, :descripcion, :perfil_id, :medalla_id, :estatus
  belongs_to :perfil
  belongs_to :medalla
  validates :nombre, presence: true
  validates :descripcion, presence: true
  validates :perfil_id, presence: true
  validates :medalla_id, presence: true
end