class Parada < ActiveRecord::Base
	#belongs_to :ruta
  attr_accessible :estatus, :latitud, :longitud, :latitude, :longitude, :nombre, :posicion, :tiempo, :distancia

  has_many :rutaparadas
  has_many :rutas, through: :rutaparadas, source: :ruta

  reverse_geocoded_by :latitud, :longitud
	after_validation :reverse_geocode  # auto-fetch address


end
