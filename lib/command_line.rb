require "json"
require "http"
require "pry"

puts "*" *30
puts "     Welcome to Coffee Search     "
puts "*" *30
puts"\n Please enter your username"

user_name = gets.chomp

if User.find_by(name: user_name)

else
  puts "welcome new user, please enter your home location"
  location = gets.chomp
  User.create(name: user_name, location: location)
end


puts "Where would you like to search for coffee?\n Please enter zip code"

location = gets.chomp

coffee_search = YelpApiAdapter.search("coffee", location)



coffee_arr = []
counter = 1
coffee_search.map do |coffee|
  coffee_hash = {}
    coffee_hash["coffee shop #{counter}"]={:name => coffee["name"]}
    coffee_hash["coffee shop #{counter}"][:location]=coffee["location"]["display_address"]
    coffee_arr << coffee_hash
    counter+=1
    coffee_arr
  end

  binding.pry

  # option_1 = "#{coffee_arr[0]["coffee shop 1"]["name"]}\n #{coffee_arr[0]["coffee shop 1"]["location"]["display_address"]}"

puts "#{coffee_arr[0]["coffee shop 1"][:name]}"
