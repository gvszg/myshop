class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      # cache items in the cart
      @order.build_item_cache_from_cart(current_cart)
      # calculate total price
      @order.calculate_total!(current_cart)
      # delete all items in cart
      current_cart.clean!
      redirect_to order_path(@order.token) # correct URL with token
    else
      flash.now[:alert] = "請確認所有欄位資訊!"
      render "carts/checkout"
    end
  end

  def show
    @order = Order.find_by(token: params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end

  def pay_with_credit_card
    @order = Order.find_by(token: params[:id])
    @order.set_payment_with!("credit_card")
    # @order.pay!
    @order.make_payment!
    flash[:notice] = "成功完成付款!"
    redirect_to '/'
  end

  private

  def order_params
    params.require(:order).permit(info_attributes: [:billing_name, :billing_address, :shipping_name, :shipping_address])
  end
end
