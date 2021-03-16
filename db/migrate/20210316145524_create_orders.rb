class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :total_price, null: false
      t.integer :shipping_fee, null: false, default: 800
      t.integer :method_of_payment, null: false
      t.integer :order_status, null: false, default: 0
      t.string :delivery_postal_code, null: false
      t.text :delivery_address, null: false
      t.string :delivery_addressee, null: false

      t.timestamps
    end
  end
end
