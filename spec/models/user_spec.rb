require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'validates a new user can be properly created' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save
      
      expect(user).to be_valid
      expect(user).to have_attributes(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
    end

    it 'validates that name is required' do
      user = User.new(name: "", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save

      expect(user.errors.messages[:name]).to eq ["can't be blank"]
    end

    it 'validates that last name is required' do
      user = User.new(name: "Test Name", last_name: "", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save

      expect(user.errors.messages[:last_name]).to eq ["can't be blank"]
    end

    it 'validates that email is required' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "", password: "TestPassword", password_confirmation: "TestPassword")
      user.save

      expect(user.errors.messages[:email]).to eq ["can't be blank"]
    end
    
    it 'validates that a new user cannot be created if the provided email exists in the database' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save

      user2 = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user2.save

      expect(user2.errors.messages[:email]).to eq ["has already been taken"]
    end

    it 'validates that a new user cannot be created if the provided email contains capital letters, and the email exists in the database in lower case' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "TEST@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save

      user2 = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user2.save

      expect(user2.errors.messages[:email]).to eq ["has already been taken"]
    end

    it 'validates that a password has a minimum length of 8 characters' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "123", password_confirmation: "123")
      user.save

      expect(user.errors.messages[:password]).to eq ["is too short (minimum is 8 characters)"]
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should pass with valid credentials' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save!

      user = User.authenticate_with_credentials("test@email.com", "TestPassword")
      expect(user).not_to be(nil)
    end

    it 'should fail if email is invalid' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save!

      user = User.authenticate_with_credentials("wrong-test@email.com", "TestPassword")
      expect(user).to be(nil)
    end

    it 'should fail if password is wrong' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save!

      user = User.authenticate_with_credentials("test@email.com", "WrongPassword")
      expect(user).to be(nil)
    end

    it 'should pass with valid credentials, even if there are extra spaces in the entered email' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save!

      user = User.authenticate_with_credentials("   test@email.com   ", "TestPassword")
      expect(user).not_to be(nil)
    end
    
    it 'should pass with valid credentials, even if there are capital letters in the entered email' do
      user = User.new(name: "Test Name", last_name: "Test Last Name", email: "test@email.com", password: "TestPassword", password_confirmation: "TestPassword")
      user.save!

      user = User.authenticate_with_credentials("TEST@email.com", "TestPassword")
      expect(user).not_to be(nil)
    end

  end
end
