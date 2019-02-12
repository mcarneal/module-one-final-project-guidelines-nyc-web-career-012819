class CreateCoffeeShops < ActiveRecord::Migration[5.0]
  def change
    create_table :coffee_shops do |t|
      t.string :name
      t.string :location 
    end
  end
end
