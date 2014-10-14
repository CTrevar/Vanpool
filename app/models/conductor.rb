class Conductor < ActiveRecord::Base
  attr_accessible :estatusConductor, :licenciaConductor, :user_id, :id, :user, :user_attributes
  validates :licenciaConductor, presence: true, length: { maximum: 50 }

  belongs_to :user
  accepts_nested_attributes_for :user
end
