class ChangeStatusToBeIntegerInOrders < ActiveRecord::Migration[6.1]
  def change
    # what if there are values in the database against this string field. how this can be handled properly?
    change_column :orders, :status, :integer, using: 'status::integer'
  end
end
