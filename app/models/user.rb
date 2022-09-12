class User < ApplicationRecord
  before_create :downcase_email

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, :name, :last_name, presence: true
  validate :compare_password_and_confirmation
  # validate :check_existing_email

  private

  def compare_password_and_confirmation
    if password != password_confirmation
      errors.add(:password, "The password and confirmation must match")
    end
  end

  def downcase_email
    self.email.downcase!
  end
  # def check_existing_email
  #   if User.find_by_email(:email.downcase)
  #     errors.add("The email already exists. Go to the <a href='/login'> login page </a> in page if you wish to log in")
  #   end
  # end
  
end
