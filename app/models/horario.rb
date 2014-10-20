class Horario < ActiveRecord::Base
	belongs_to :ruta
  attr_accessible :hora, :ruta_id, :id
end
