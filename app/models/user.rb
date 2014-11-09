class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
     :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.name = auth.info.name
        user.password = Devise.friendly_token[0,20]
      end
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :name, :admin, :provider, :uid
  #attr_accessible :email, :name,:password, :password_confirmation, :idTipoUsuario, :facebookidUsuario,
  #                :openpayidUsuario, :apellidoPaterno, :apellidoMaterno, :fechaNacimiento, :estatusUsuario, :admin
  #has_secure_password
  has_one :clients, dependent: :destroy

  
  #before_save { |user| user.email = email.downcase }
  #before_save :create_remember_token
  #validates :name, presence: true, length: { maximum: 50 }
  # validates :password, presence: true, length: { minimum: 6 }, on: :create
  # validates :password_confirmation, presence: true, on: :create
  #validate :passwords, on: :create
  #validate :password_update, on: :update
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true,
  #                  format: { with: VALID_EMAIL_REGEX },
  #                  uniqueness: { case_sensitive: false }
  #validates :apellidoPaterno, length: { maximum: 50 }
  #validates :apellidoMaterno, length: { maximum: 50 }
  #validates :fechaNacimiento, length: { maximum: 50 }
    
end
