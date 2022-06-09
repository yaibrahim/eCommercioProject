class AddDefaultValueOfQuantityInOrderItem < ActiveRecord::Migration[6.1]
  def change
    change_column :order_items, :quantity, :integer, default: 1
  end
end
