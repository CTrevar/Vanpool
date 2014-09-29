class Ruta < ActiveRecord::Base
	self.table_name = "rutas"
  attr_accessible :estatus, :gmaps, :kilometros, :nombre, :precio, :van_id, :conductor_id
  has_many :viajes
  validates :precio, numericality: true
  belongs_to :van
end
