class Van < ActiveRecord::Base
  has_one :pais
  validates_presence_of :modelo, :placa, message: "no puede estar en blanco"
  validates :modelo, format: {with: /\A[a-zA-Z]+\z/, message: "solo letras"}
  attr_accessible :activa, :capacidad, :estatus, :fecha_compra, :kilometro_recorrido, :modelo, :placa, :pais_id, :co2gxkm, :rutas_attributes
    
   has_many :rutas
   accepts_nested_attributes_for :rutas

   #validates :modelo, :presence => { :message => "no puede estar en blanco" }
   #validates :placa, :presence => { :message => "no puede estar en blanco" }
end
