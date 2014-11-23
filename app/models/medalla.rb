class Medalla < ActiveRecord::Base
	attr_accessible :nombre, :puntos, :tipomedalla_id, :imagen, :estatus, :estado, :descripcion
	belongs_to :tipomedalla 
	has_many :medallasmuros
	has_many :clientes, through: :medallasmuros, source: :cliente
	has_one :saldopromocion
	has_many :regalo
	validates_presence_of :nombre, :puntos, :tipomedalla_id, :estado, message: "no puede estar en blanco"
end
