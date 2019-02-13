require_relative '../config/environment'


welcome
user = get_user
coffee_search = zip_search
coffee_array = coffee_list(coffee_search)
clean_list(coffee_array)

binding.pry

def favorite_coffee(coffee_array, user)

  puts "\nWould you like to add a coffee to favorites?\n
  (YES or NO)"
  answer = gets.chomp
  if answer == "yes"
    puts "\n Please enter your number choice 1 - 5"
    selection = gets.chomp.to_i
      c1 = CoffeeShop.find_by(name: coffee_array[selection -1]["coffee shop #{selection}"][:name])
      if CoffeeShop.find_by(name: coffee_array[selection -1]["coffee shop #{selection}"][:name])
        puts "coffee shop already exists"
      else
      CoffeeShop.create(name: coffee_array[selection -1]["coffee shop #{selection}"][:name], location: coffee_array[selection -1]["coffee shop #{selection}"][:location])

      Favorite.create(name: coffee_array[selection -1]["coffee shop #{selection}"][:name], location: coffee_array[selection -1]["coffee shop #{selection}"][:location], user_id: User.find_by(name: user).id, coffee_shop_id: CoffeeShop.find_by(name: coffee_array[selection -1]["coffee shop #{selection}"][:name]).id)
      end
  elsif answer == "no"
    # send to menu
  else
    error_message
    favorite_coffee(coffee_array, user)
  end
end

favorite_coffee(coffee_array, user)

binding.pry

puts "bye bye"
