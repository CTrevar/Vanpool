class Tipomedalla < ActiveRecord::Base
	has_many :medalla
  attr_accessible :nombre
end
