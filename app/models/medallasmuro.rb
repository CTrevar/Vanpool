class Medallasmuro < ActiveRecord::Base
  attr_accessible :cliente_id, :cobrado, :medalla_id
  belongs_to :cliente
  belongs_to :medalla 
end
