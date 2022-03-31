class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :user_id
      t.string :status
      t.integer :coupon_id

      t.timestamps
    end
  end
end
