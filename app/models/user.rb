class User < ApplicationRecord
  before_create :downcase_email_and_strip_whitespace

  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, :name, :last_name, presence: true
  validate :compare_password_and_confirmation
  validates_length_of :password, minimum: 8 

  
  def self.authenticate_with_credentials(email, password)
    #Downcase email and strip whitespace before validation (so it matches the downcased/stripped emails stored in database)
    email = email.downcase.strip

    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      @user
    elsif
      # errors.add(:password, "No match, please confirm email and password")
      nil
    end
  end

  private

  def compare_password_and_confirmation
    if password != password_confirmation
      errors.add(:password, "The password and confirmation must match")
    end
  end

  #Downcase all emails and strip whitespace before saving to the database, to avoid mixed case issues
  def downcase_email_and_strip_whitespace
    self.email.downcase!
    self.email.strip!
  end

end
