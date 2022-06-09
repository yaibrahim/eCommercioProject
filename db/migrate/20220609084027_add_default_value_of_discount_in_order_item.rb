class AddDefaultValueOfDiscountInOrderItem < ActiveRecord::Migration[6.1]
  def change
    change_column :order_items, :discount, :float, default: 0.0
  end
end
