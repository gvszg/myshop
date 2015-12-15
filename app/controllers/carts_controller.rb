class CartsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
  end

  def checkout
    @order = current_user.orders.build
    @info = @order.build_info # build_association
  end

  def clean
    current_cart.clean!
    flash[:warning] = "Cart already cleaned!"
    redirect_to carts_path
  end
end
