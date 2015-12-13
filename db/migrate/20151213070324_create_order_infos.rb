class CreateOrderInfos < ActiveRecord::Migration
  def change
    create_table :order_infos do |t|
      t.integer :order_id
      t.string :billing_name, :billing_address, :shipping_name, :shipping_address
      t.timestamps
    end
  end
end
