class Sugerencia < ActiveRecord::Base
  self.table_name = "sugerencias"
  attr_accessible :hora_inicio, :id
  has_many :sugerenciaparadas
end
