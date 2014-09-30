class Retroaspecto < ActiveRecord::Base
  attr_accessible :estatus, :nombre
  has_many :retroalimentacions
end
