class Ruta < ActiveRecord::Base
  attr_accessible :estatus, :gmaps, :kilometros, :nombre, :precio, :van_id, :conductor_id
  has_many :viajes
  validates :precio, numericality: true
end
