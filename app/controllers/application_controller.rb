class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  def purchase_list
    @order.line_items.each do |item| 
      item
    end
  end
  helper_method :purchase_list

  def purchase_list_total
    running_total = 0
    purchase_list.each do |item|
      running_total += item.price_cents * item.quantity
    end
    running_total
  end
  helper_method :purchase_list_total

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  
end
