class User < ApplicationRecord
  before_create :downcase_email

  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, :name, :last_name, presence: true
  validate :compare_password_and_confirmation


  private

  def compare_password_and_confirmation
    if password != password_confirmation
      errors.add(:password, "The password and confirmation must match")
    end
  end

  def downcase_email
    self.email.downcase!
  end

end
