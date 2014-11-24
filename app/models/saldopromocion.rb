class Saldopromocion < ActiveRecord::Base
  attr_accessible :nombre, :descripcion, :cantidad, :medalla_id, :estatus
  belongs_to :medalla
	validates :nombre, presence: true
  validates :descripcion, presence: true
  validates :cantidad, presence: true
  validates :cantidad, :numericality => {:greater_than_or_equal_to => 1}
  validates :medalla_id, presence: true
end
