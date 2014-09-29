class Van < ActiveRecord::Base
  has_one :pais
  validates_presence_of :modelo, :placa, message: "no puede estar en blanco"
  validates :modelo, format: {with: /\A[a-zA-Z]+\z/, message: "solo letras"}
  attr_accessible :activa, :capacidad, :estatus, :fecha_compra, :kilometro_recorrido, :modelo, :placa, :pais_id, :co2gxkm
   has_many :rutas
end
