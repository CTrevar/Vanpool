class Cliente < ActiveRecord::Base

  attr_accessible :nivel_id, :puntaje, :user_id, :estatus
  belongs_to :user
  belongs_to :nivel
  has_many :medallasmuros
  has_many :medallas, through: :medallasmuros, source: :medalla
  has_many :reservacions
  has_many :reportes

end
