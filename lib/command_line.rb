require "json"
require "http"
require "pry"


def welcome
  puts "*" *30
  puts "     Welcome to Coffee Search     "
  puts "*" *30
end

def get_user
  puts"\n Please enter your username"
  user_name = gets.chomp.strip
  if User.find_by(name: user_name)
    puts "Welcome back #{user_name}"
  else
    puts "welcome new user, please enter your home location"
    location = gets.chomp
    User.create(name: user_name, location: location)
  end
user_name
end

def zip_search
  puts "Where would you like to search for coffee? Please enter zip code"
  location = gets.chomp
  coffee_search = YelpApiAdapter.search("coffee", location)
  coffee_search
end



def coffee_list(coffee_search)
coffee_arr = []
counter = 1
coffee_search.map do |coffee|
  coffee_hash = {}
    coffee_hash["coffee shop #{counter}"]={:name => coffee["name"]}
    coffee_hash["coffee shop #{counter}"][:location]=coffee["location"]["display_address"]
    coffee_arr << coffee_hash
    counter+=1
  end
  coffee_arr
end

def clean_list(coffee_array)
  counter = 0
  coffee_array.each do |shop|
     puts "#{counter + 1}.  #{coffee_array[counter]["coffee shop #{counter +1}"][:name]} \n   Location: #{coffee_array[counter]["coffee shop #{counter +1}"][:location].join(" ")}"
    counter += 1
  end
end

def error_message
  puts "Invalid entry"
end

def favorite_coffee(coffee_array, user)

  puts "\nWould you like to add a coffee to favorites?\n
  (YES or NO)"
  answer = gets.chomp
  if answer == "yes"
    puts "\n Please enter your number choice 1 - 5"
    selection = gets.chomp.to_i

    shop_name = coffee_array[selection -1]["coffee shop #{selection}"][:name]

    shop_location = coffee_array[selection -1]["coffee shop #{selection}"][:location].join(" ")

      c1 = CoffeeShop.find_by(name: coffee_array[selection -1]["coffee shop #{selection}"][:name])

      if Favorite.find_by(user_id: User.find_by(name: user).id, coffee_shop_id: c1.id)
      puts "You have already have this in your favorites"
      menu
      else
        binding.pry
      CoffeeShop.find_or_create_by(name: shop_name, location: shop_location)

      Favorite.create(name: coffee_array[selection -1]["coffee shop #{selection}"][:name], location: coffee_array[selection -1]["coffee shop #{selection}"][:location], user_id: User.find_by(name: user).id, coffee_shop_id: CoffeeShop.find_by(name: coffee_array[selection -1]["coffee shop #{selection}"][:name]).id)
      menu
      end
  elsif answer == "no"
    menu
  else
    error_message
    favorite_coffee(coffee_array, user)
    menu
  end
end
  # option_1 = "#{coffee_arr[0]["coffee shop 1"]["name"]}\n #{coffee_arr[0]["coffee shop 1"]["location"]["display_address"]}"
#
# puts "#{coffee_arr[0]["coffee shop 1"][:name]}"



def menu
  puts "
  Main MENU
    --1--  Get me more JAVA!
    --2--  View favorites
    --3--  Delete favorites
    --4--  EXIT App
    "
    input = gets.chomp
    if input == "1"
      user = get_user
      get_me_more_java(user)
    elsif input == "2"
      # view_favorites
    elsif input == "3"
      delete_favorites
    elsif input == "4"
      exit_app
    else
      puts "Please select from the following:"
      menu
    end
  end

def delete_favorites
  puts "
    DELETE MENU
    --1--  Delete a specific favorite
    --2--  Delete all favorites
    --3--  Return to Main MENU
    "
    input = ""
    input = gets.chomp
    if input == "1"
      puts "Please type in the **EXACT** name of the coffeeshop you would like to delete"
      input = gets.chomp
      typo_checker(input)
    elsif input == "2"
      # view_favorites.destroy
      puts "Your favorites list is empty"
      delete_favorites
    elsif input == "3"
      menu
    else
      puts "Please select from the following:"
      delete_favorites
      end
    end

def typo_checker(input)
  if input != CoffeeShop.where(name: input)
    puts "Sorry, there must be a typo please try again"
    delete_favorites
  else
shop_to_delete = Coffeeshop.where(name: input)
  shop_to_delete.destroy
puts "#{input.upcase!} has been successfully deleted "
delete_favorites
  end
end

def exit_app
  puts "Thank you for using Java Beans: Where a fresh brew is just around the corner!"
  exit!
end

def get_me_more_java(user)
  coffee_search = zip_search
  coffee_array = coffee_list(coffee_search)
  clean_list(coffee_array)
  favorite_coffee(coffee_array, user)
end
# favorite_coffee(coffee_array, user)

# "1.  #{coffee_array[0]["coffee shop 1"][:name]}   #{coffee_array[0]["coffee shop 1"][:location]}"
#


# def find_coffee
#   shop_name = {}
#   coffee_search = YelpApiAdapter.search("coffee", 11237)
#   coffee_search.each do |shops|
#   end
# end
