class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["ADMIN_USER_NAME"], password: ENV["ADMIN_PASSWORD"]

  def show
    @productsCount = Product.count
    @categoriesCount = Category.count
  end
end
