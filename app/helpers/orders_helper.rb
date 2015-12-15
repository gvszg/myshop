module OrdersHelper
  def order_timestamp(order)
    order.created_at.to_s(:long)
  end
end
