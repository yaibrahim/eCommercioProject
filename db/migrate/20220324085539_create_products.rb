class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :serial_number
      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end
