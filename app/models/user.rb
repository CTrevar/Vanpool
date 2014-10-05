class User < ActiveRecord::Base
  attr_accessible :email, :name,:password, :password_confirmation, :idTipoUsuario, :facebookidUsuario,
                  :openpayidUsuario, :apellidoPaterno, :apellidoMaterno, :fechaNacimiento, :estatusUsuario, :admin
  has_secure_password
  has_one :clients, dependent: :destroy

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
            class_name: "Relationship",
            dependent:  :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  # validates :password, presence: true, length: { minimum: 6 }, on: :create
  # validates :password_confirmation, presence: true, on: :create
  validate :passwords, on: :create
  validate :password_update, on: :update
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :apellidoPaterno, length: { maximum: 50 }
  validates :apellidoMaterno, length: { maximum: 50 }
  validates :fechaNacimiento, length: { maximum: 50 }
    def feed
    # This is preliminary. See "Following users" for the full implementation.
    #Micropost.where("user id = ?", id)
      microposts
    end

    def following?(other_user)
      relationships.find_by_followed_id(other_user.id)
    end
    
    def follow!(other_user)
      relationships.create!(followed_id: other_user.id)
    end

    def unfollow!(other_user)
      relationships.find_by_followed_id(other_user.id).destroy
    end

  def passwords
    # errors.add(:password,'ingrese password') unless self.password.present?
    # errors.add(:password,'mayor a 6 letras') unless self.password.length > 6
    validates_presence_of :password
    validates_length_of :password, minimum: 6
    validates_presence_of :password_confirmation
    # errors.add(:password_confirmation,'ingrese password') unless self.password_confirmation?
    # validates_confirmation_of
    # errors.add(:password_digest,'ingrese password digest') unless self.password_digest?
  end

  def password_update
    validates_length_of :password, {:minimum => 6, :maximum => 20, :allow_nil => true}
    # validates :password,  :presence => true,
    #           :confirmation => true,
    #           :length => {:minimum => 6,:maximum => 20},
    #           :if => :password
    # validates :password_confirmation,  :presence => true,
    #           :if => :password
  end


  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
