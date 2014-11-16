class Tipocalificacion < ActiveRecord::Base
	has_many :retroalimentacion
  attr_accessible :nombre
end