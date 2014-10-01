class Medalla < ActiveRecord::Base
	attr_accessible :nombre, :puntos, :tipomedalla_id, :imagen, :estatus, :estado, :descripcion
	belongs_to :tipomedalla 
	has_many :medallasmuros
	has_many :clientes, through: :medallasmuros, source: :cliente
	has_one :descuentos
end
