require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'validates a new user can be properly created' do
      @user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
  
      expect(@user).to have_attributes(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
    end
    
  end
end
