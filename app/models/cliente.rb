class Cliente < ActiveRecord::Base
  acts_as_heir_of :user
  attr_accessible :nivel, :puntaje

end
