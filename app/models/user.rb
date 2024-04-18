class User < ApplicationRecord

  EMAIL_REGEX = /\A[\w!#$%&'*+\/=?`{|}~^-]+(?:\.[\w!#$%&'*+\/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}\z/

  has_secure_password

  has_many :posts
  has_many :comments

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email,
            presence: true,
            format: { with: EMAIL_REGEX },
            length: { minimum: 7, maximum: 254 },
            uniqueness: { case_sensitive: false }
end
