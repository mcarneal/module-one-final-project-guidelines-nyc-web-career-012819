class CreateReviewsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :message
      t.integer :user_id
      t.integer :coffee_shop_id
    end 
  end
end
