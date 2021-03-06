module Account::OrdersHelper
  def payment_service_button(order, payment_type)
    payment_service_for order,
      order.user.email,
      service: :allpay,
      html: { authenticity_token: false, enforce_utf8: false, method: :post, class: "pull-right", style: "padding: 10px;" } do |service|
      service.merchant_trade_no   "#{order.id}s#{Time.now.strftime("%Y%m%d%H%M%S")}"
      service.merchant_trade_date order.created_at
      service.total_amount        order.total
      service.description         "order_sample"
      service.item_name           "order_sample"
      service.choose_payment      payment_gateway_type(payment_type)
      
      # 付款完成通知回傳網址
      # 'ReturnURL'
      service.notify_url          allpay_notify_order_url(order.token, type: payment_type)
      
      # Client 端返回廠商網址
      # 'ClientBackURL'
      # service.return_url          allpay_notify_order_url(order.token, payment_type: payment_type)
      service.return_url          root_url
      service.encrypted_data
      submit_tag t("orders.payment_type.#{payment_type}") , name: nil, class: "btn btn-lg btn-danger btn-group"
    end
  end

  private

  def payment_gateway_type(payment_type)
    case payment_type
    when "credit_card"
      ActiveMerchant::Billing::Integrations::Allpay::PAYMENT_CREDIT_CARD
    when "cvs"
      ActiveMerchant::Billing::Integrations::Allpay::PAYMENT_CVS
    when "atm"
      ActiveMerchant::Billing::Integrations::Allpay::PAYMENT_ATM
    end
  end
end
