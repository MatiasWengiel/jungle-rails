require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'validates the presence of a name' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: 1, image: "../../db/seed_assets/apparel1.jpg", price: 2000)
      @product.save!

      expect(@product).to have_attributes(:name => "Test Product")
    end

    it 'validates the presence of a description' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: 1, image: "../../db/seed_assets/apparel1.jpg", price: 2000)
      @product.save!

      expect(@product).to have_attributes(:description => "This is a product to be tested")
    end

    it 'validates the presence of a category_id' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: 1, image: "../../db/seed_assets/apparel1.jpg", price: 2000)
      @product.save!

      expect(@product).to have_attributes(:category_id => @category.id)
    end

    it 'validates the presence of a quantity' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: 1, image: "../../db/seed_assets/apparel1.jpg", price: 2000)
      @product.save!

      expect(@product).to have_attributes(:quantity => 1)
    end

    it 'validates the presence of a price' do
      @category = Category.new(name: "Test Category")
      @category.save
      @product = Product.new(name: "Test Product", description: "This is a product to be tested", category_id: @category.id, quantity: 1, image: "not tested", price: 2000)
      @product.save!

      expect(@product).to have_attributes(:price => 2000)
    end
  end
end
