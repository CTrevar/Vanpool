class Ruta < ActiveRecord::Base
  attr_accessible :conductor_id, :estatus, :gmaps, :kilometros, :nombre, :precio, :van_id
  has_many :viajes
end
