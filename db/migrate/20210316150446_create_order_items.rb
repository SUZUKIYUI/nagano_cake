class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :tax_included_price, null: false
      t.integer :amount, null: false
      t.integer :production_status, null: false, default: 0

      t.timestamps
    end
  end
end
