class Ruta < ActiveRecord::Base
  attr_accessible :estatus, :gmaps, :kilometros, :nombre, :precio
  validates :precio, numericality: true
end
