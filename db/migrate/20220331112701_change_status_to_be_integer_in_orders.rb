class ChangeStatusToBeIntegerInOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :integer, using: 'status::integer'
  end
end
