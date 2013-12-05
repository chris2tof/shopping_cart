class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_cart


  private

  def set_cart
  	if session[:cart].present?
  		@cart = Cart.find(session[:cart][:id]) rescue nil
  	end
  	unless @cart
			@cart = Cart.create
			session[:cart] = {id: @cart.id}
		end
  end

end
