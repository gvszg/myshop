module OrdersHelper
  def order_timestamp(order)
    order.created_at.to_s(:long)
  end

  def order_state(order)
    t("orders.order_state.#{order.aasm_state}")
  end

  def order_options_for_admin(order)
    render :partial => "admin/orders/state_option", :locals => { :order => order }
  end

  def order_paid_state(order)
    if order.paid
      "已付款"
    else
      "未付款"
    end
  end
end
