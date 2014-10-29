class Ciudad < ActiveRecord::Base
  belongs_to :pais
  attr_accessible :clave, :estauts, :nombre, :id, :pais_id
  has_many :zonas
end
