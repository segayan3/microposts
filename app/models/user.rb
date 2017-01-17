class User < ActiveRecord::Base
  before_save {
    self.email = self.email.downcase
  }
  
  has_many :microposts
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false } # case_sensitiveは大文字小文字の区別をするかどうか
  has_secure_password
end
