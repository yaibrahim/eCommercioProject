class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :product_id
      t.text :review_message

      t.timestamps
    end
  end
end
