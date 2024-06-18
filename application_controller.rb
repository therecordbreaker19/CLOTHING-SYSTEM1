class ApplicationController < ActionController::Base
	include SessionsHelper
  protect_from_forgery with: :exception
  before_action :set_current_cart

  private

  def set_current_cart
    if logged_in?
      @current_cart = current_user.carts.find_or_create_by(id: session[:cart_id])
      session[:cart_id] ||= @current_cart.id
    else
      @current_cart = Cart.find_by(id: session[:cart_id]) || Cart.create
      session[:cart_id] ||= @current_cart.id
    end
  end


   def logged_in_user
    unless logged_in?
      flash[:danger] = 'Please log in.'
      redirect_to login_url
	   end
	end
end
