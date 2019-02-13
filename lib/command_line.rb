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
  user_name = gets.chomp
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
  # option_1 = "#{coffee_arr[0]["coffee shop 1"]["name"]}\n #{coffee_arr[0]["coffee shop 1"]["location"]["display_address"]}"
#
# puts "#{coffee_arr[0]["coffee shop 1"][:name]}"
