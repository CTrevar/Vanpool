class Session < ActiveRecord::Base
  attr_accessible :email, :password

  validates :name, presence: true
  validates :password, presence: true
  
end