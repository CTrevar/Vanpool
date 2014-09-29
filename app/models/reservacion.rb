class Reservacion < ActiveRecord::Base
  attr_accessible :cliente_id, :estadotipo_id, :estatus, :referenciapago_id, :viaje_id
  belongs_to :cliente
  belongs_to :viaje
  has_many :retroalimentacions

end
