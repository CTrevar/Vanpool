class Frecuencia < ActiveRecord::Base
	self.table_name = "frecuencias"
	belongs_to :ruta
  attr_accessible :jueves, :lunes, :martes, :miercoles, :sabado, :viernes, :domingo
end
