class Perfil < ActiveRecord::Base
  attr_accessible :nombre, :descripcion
  has_many :clientes
  has_many :regalos
end