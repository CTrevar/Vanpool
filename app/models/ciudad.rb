class Ciudad < ActiveRecord::Base
  belongs_to :pais
  attr_accessible :clave, :estauts, :nombre
end
