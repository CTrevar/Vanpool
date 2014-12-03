class Share < ActiveRecord::Base
  belongs_to :reservacion
  attr_accessible :reservacion_id, :id
  
end
