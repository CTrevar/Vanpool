class Saldopromocion < ActiveRecord::Base
	attr_accessible :nombre, :descripcion, :cantidad, :medalla_id, :estatus
	belongs_to :medalla
	#has_attached_file :imagenmedalla, :default_url => "/assets/medals/viaje1.png"
	#validates_attachment_content_type :imagenmedalla, :content_type => /\Aimage\/.*\Z/
end
