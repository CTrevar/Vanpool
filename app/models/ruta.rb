class Ruta < ActiveRecord::Base
	self.table_name = 'rutas'
	
  attr_accessible :estatus, :gmaps, :kilometros, :nombre, :precio, :hora_inicio, :van_id, :conductor_id, :zona_id, :viajes_attributes, :frecuencia_attributes, :van_attributes, :van, :id
  has_many :viajes
  #has_many :paradas
  has_one :frecuencia
  has_one :horario
  belongs_to :van
  belongs_to :conductor
  belongs_to :zona
  has_many :rutaparadas
  has_many :paradas, through: :rutaparadas, source: :parada
  has_many :liders
	#accepts_nested_attributes_for :viajes, :allow_destroy => true
	#accepts_nested_attributes_for :paradas
	#accepts_nested_attributes_for :frecuencia
  
  validates :nombre, :presence => { :message => "no puede estar en blanco" }
  validates :precio, :presence => { :message => "no puede estar en blanco" }
  validates_numericality_of :precio, :message => "tiene que ser un número"
  validates :van, :presence => { :message => "no puede estar en blanco" }
  validates :conductor, :presence => { :message => "no puede estar en blanco" }
    
end
