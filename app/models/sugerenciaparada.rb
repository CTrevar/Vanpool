class Sugerenciaparada < ActiveRecord::Base
  attr_accessible :latitud, :longitud, :posicion, :sugerencia_id, :nombre
  belongs_to :sugerencia
  validates_presence_of :latitud, :posicion, :longitud

  reverse_geocoded_by :latitud, :longitud, :address => :nombre
	after_validation :reverse_geocode  # auto-fetch address
end
