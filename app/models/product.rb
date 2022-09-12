class Product < ApplicationRecord
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true
  validates :description, presence: true
end
