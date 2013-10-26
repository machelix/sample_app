class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :name, presence: true , length: { maximum: 50, minimum: 2}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }  , length: { maximum: 50, minimum: 2} ,uniqueness: { case_sensitive: false }

  validates :password, length: { maximum: 10 , minimum: 5 }

  has_secure_password

  mount_uploader :avatar, AvatarUploader

  before_create :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
