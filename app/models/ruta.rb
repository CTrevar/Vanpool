class Ruta < ActiveRecord::Base
	self.table_name = 'rutas'
	
  attr_accessible :estatus, :gmaps, :kilometros, :nombre, :precio, :hora_inicio, :van_id, :conductor_id, :viajes_attributes, :frecuencia_attributes, :van_attributes, :van, :id
  has_many :viajes
  #has_many :paradas
  has_one :frecuencia
  has_one :horario
  belongs_to :van
  has_many :rutaparadas
  has_many :paradas, through: :rutaparadas, source: :parada
	#accepts_nested_attributes_for :viajes, :allow_destroy => true
	#accepts_nested_attributes_for :paradas
	#accepts_nested_attributes_for :frecuencia
  #validates :precio, numericality: true
 
    
end
