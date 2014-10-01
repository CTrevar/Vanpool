class Descuento < ActiveRecord::Base
  attr_accessible :descripcion, :estatus, :medalla_id, :nombre, :porcentaje, :vigencia
  belongs_to :medalla
end
