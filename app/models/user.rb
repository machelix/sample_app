class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :name, presence: true , length: { maximum: 50, minimum: 2}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }  , length: { maximum: 50, minimum: 2} ,uniqueness: { case_sensitive: false }

  validates :password, length: { maximum: 10 , minimum: 5 }

  has_secure_password
end
