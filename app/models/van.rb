class Van < ActiveRecord::Base
   attr_accessible :placa, :modelo, :capacidad, :co2gxkm, :pais_id, :fechacompra, :activa, :estatus
   has_many :rutas
end
