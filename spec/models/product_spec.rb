require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'validates that a new product can be created' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: 1, image: "not tested", price: 2000)
      @product.save!

      #Note: Price in Product creation is entered as dollars and converted to cents. Amount in Money.new is passed as cents directly (hence the extra two zeros)
      expect(@product).to have_attributes(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: 1, price: Money.new(200000))
    end

    it 'validates the presence of a name' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "", description: "This is a product to be tested", category_id: @category.id, quantity: 1, image: "not tested", price: 2000)
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to eq ["can't be blank"]
    end

    it 'validates the presence of a description' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product",  description: "", category_id: @category.id, quantity: 1, image: "not tested", price: 2000)
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:description]).to eq ["can't be blank"]
    end

    it 'validates the presence of a category_id' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: "", quantity: 1, image: "not tested", price: 2000)
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to eq ["must exist", "can't be blank"]
    end

    it 'validates the presence of a quantity' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: nil, image: "not tested", price: 2000)
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to eq ["can't be blank", "is not a number"]
    end

    #Not on requirements from Compass, but makes sense as the current UI allows for negative numbers to be entered, which is nonsensical. TODO: Fix UI
    it 'validates that the quantity is greater than or equal to zero' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: -1, image: "not tested", price: 2000)
      @product.save

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to eq ["must be greater than or equal to 0"]
    end

    it 'validates the presence of a price' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: 1, image: "not tested")
      @product.save


      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to eq ["is not a number", "can't be blank"]
    end
  end
end
