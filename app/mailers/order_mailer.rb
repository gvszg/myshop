class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    @order = order
    @user = @order.user
    @order_info = @order.info
    @order_items = @order.items

    mail to: @user.email, subject: "[MyShop] 感謝您完成本次的下單，以下是您這次購物明細:"
  end
end
