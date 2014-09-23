class Medalla < ActiveRecord::Base
	attr_accessible :nombre, :puntos, :tipomedalla_id, :imagen, :estatus
	belongs_to :tipomedalla 
	has_many :medallasmuros
	has_many :clientes, :throught => :medallasmuros
end
