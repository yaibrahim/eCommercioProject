class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.float :discount # restrict # decimal limit

      t.timestamps
    end
  end
end
