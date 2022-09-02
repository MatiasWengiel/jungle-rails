class User < ApplicationRecord

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, :name, :last_name, presence: true
  
end
