class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :allpay_notify

  protect_from_forgery except: :allpay_notify

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      # cache items in the cart
      @order.build_item_cache_from_cart(current_cart)
      # calculate total price
      @order.calculate_total!(current_cart)
      # delete all items in cart
      current_cart.clean!
      OrderMailer.notify_order_placed(@order).deliver!
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
    redirect_to account_orders_path
  end

  def allpay_notify
    order = Order.find_by(token: params[:id])
    payment_type = params[:payment_type]

    if params[:RtnCode] == "1"
      order.set_payment_with!(payment_type)
      order.make_payment!
      render text: "1|OK", status: 200
      flash[:notice] = "交易成功！"
      redirect_to account_orders_path
    else
      flash[:alert] = "交易失敗，請檢查帳務資料！"
      redirect_to :back
    end
  end

  private

  def order_params
    params.require(:order).permit(info_attributes: [:billing_name, :billing_address, :shipping_name, :shipping_address])
  end
end
