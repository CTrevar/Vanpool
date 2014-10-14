class Reporte < ActiveRecord::Base
  attr_accessible :cliente_id, :descripcion, :estatus
  belongs_to :cliente
end
