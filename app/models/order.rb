class Order < ActiveRecord::Base
  include Tokenable
  include AASM

  belongs_to :user
  has_one :info, class_name: "OrderInfo", dependent: :destroy
  has_many :items, class_name: "OrderItem", dependent: :destroy

  accepts_nested_attributes_for :info

  scope :recent, -> { order("id DESC") }
  
  def calculate_total!(cart)
    self.total = cart.total_price
    self.save
  end

  def paid?
    paid
  end

  def set_payment_with!(method)
    update_column(:payment_method, method)
  end

  def pay!
    update_column(:paid, true)
  end

  def build_item_cache_from_cart(cart)
    cart.cart_items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.product.title
      item.quantity = cart_item.quantity
      item.price = cart_item.product.price
      item.save
    end
  end

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned

    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid 
    end

    event :ship do
      transitions from: :paid,         to: :shipping
    end

    event :deliver do
      transitions from: :shipping,     to: :shipped
    end

    event :returned_good do
      transitions from: :shipped,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_cancelled
    end
  end 
end

# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  total          :integer          default(0)
#  paid           :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  token          :string(255)
#  payment_method :string(255)
#  aasm_state     :string(255)      default("order_placed")
#
# Indexes
#
#  index_orders_on_aasm_state  (aasm_state)
#  index_orders_on_token       (token)
#
