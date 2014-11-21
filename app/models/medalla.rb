class Medalla < ActiveRecord::Base
	attr_accessible :nombre, :puntos, :tipomedalla_id, :imagen, :estatus, :estado, :descripcion, :imagenmedalla
	belongs_to :tipomedalla 
	has_many :medallasmuros
	has_many :clientes, through: :medallasmuros, source: :cliente
	has_one :descuentos
	#has_attached_file :imagenmedalla, :default_url => "/assets/medals/viaje1.png"
	#validates_attachment_content_type :imagenmedalla, :content_type => /\Aimage\/.*\Z/
end
