class User < ApplicationRecord

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, :name, :last_name, presence: true
  validate :compare_password_and_confirmation

  private

  def compare_password_and_confirmation
    if (:password != :password_confirmation)
      errors.add("The password and confirmation must match")
    end
  end
  
end
