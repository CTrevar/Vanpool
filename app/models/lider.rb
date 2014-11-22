class Lider < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :ruta
  attr_accessible :record, :cliente_id, :ruta_id, :estatus, :id
  
end
