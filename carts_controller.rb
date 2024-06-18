class CartsController < ApplicationController
  before_action :logged_in_user, only: %i[show destroy]
  before_action :set_current_cart, only: [:show]

  def show
    # The @current_cart is already set by the before_action
    @cart = @current_cart
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

  private

  def find_or_create_cart
    return unless current_user

    current_user.carts.find_by(id: params[:id]) || current_user.carts.create
  end

  def set_current_cart
    @current_cart = find_or_create_cart
    session[:cart_id] = @current_cart&.id
  end

end
