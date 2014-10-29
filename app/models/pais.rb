class Pais < ActiveRecord::Base
  attr_accessible :clave, :divisa, :estatus, :nombre
  has_many :ciudads
end
