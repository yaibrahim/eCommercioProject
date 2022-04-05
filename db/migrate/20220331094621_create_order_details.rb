class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :coupon_id
      t.integer :user_id
      t.string :status

      # seems duplicate of orders
      t.timestamps
    end
  end
end
