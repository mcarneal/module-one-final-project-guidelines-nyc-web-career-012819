class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :name
      t.string :location
      t.integer :user_id
      t.integer :coffee_shop_id
    end 
  end
end
