class Nivel < ActiveRecord::Base
	has_many :cliente
  attr_accessible :estatus, :nombre, :rangomaximo
end
