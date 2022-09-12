require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'validates a new user can be properly created' do
      @user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      @user.save

      expect(@user).to have_attributes(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
    end
    
    it 'validates that a new user cannot be created if the provided email exists in the database' do
      @user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      @user.save

      @user2 = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      @user2.save

      expect(@user2.errors.messages[:email]).to eq ["has already been taken"]
    end
  end
end
