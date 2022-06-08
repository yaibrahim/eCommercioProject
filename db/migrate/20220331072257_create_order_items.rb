class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :quantity # set default values for obvious/usual input fields
      t.float :discount # same as above

      # order items and cart items should be the same IMO.

      t.timestamps
    end
  end
end
