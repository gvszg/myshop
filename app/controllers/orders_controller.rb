class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      # cache items in the cart
      @order.build_item_cache_from_cart(current_cart)
      # calculate total price
      @order.calculate_total!(current_cart)
      redirect_to @order
    else
      flash.now[:alert] = "Please check all your information!"
      render "carts/checkout"
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end

  private

  def order_params
    params.require(:order).permit(info_attributes: [:billing_name, :billing_address, :shipping_name, :shipping_address])
  end
end
