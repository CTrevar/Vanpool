class Parada < ActiveRecord::Base
  attr_accessible :estatus, :latitud, :longitud, :nombre
end
