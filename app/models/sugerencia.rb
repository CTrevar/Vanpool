class Sugerencia < ActiveRecord::Base
  self.table_name = "sugerencias"
  attr_accessible :hora_inicio, :id
  has_many :sugerenciaparadas
  validates_presence_of :hora_inicio
end
