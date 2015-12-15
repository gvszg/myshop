module OrdersHelper
  def order_timestamp(order)
    order.created_at.to_s(:long)
  end

  def order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end
end
