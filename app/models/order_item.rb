class OrderItem < ActiveRecord::Base
end

# == Schema Information
#
# Table name: order_items
#
#  id           :integer          not null, primary key
#  order_id     :integer
#  product_name :string(255)
#  price        :integer
#  quantity     :integer
#  created_at   :datetime
#  updated_at   :datetime
#
