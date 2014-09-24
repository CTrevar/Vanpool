class Medallasmuro < ActiveRecord::Base
  attr_accessible :cliente_id, :cobrado, :medalla_id
  belongs_to :medalla 
  belongs_to :cliente
  
end
