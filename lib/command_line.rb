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

coffee_hash = {}
counter = 0
parsed_coffee = coffee_search.each do |coffee|
  if coffee_hash["coffee shop #{counter}"]
    counter+=1
    coffee_hash["coffee shop #{counter}"][:location]=coffee["location"]
  else
    coffee_hash["coffee shop #{counter}"]={:name => coffee["name"]}
    coffee_hash["coffee shop #{counter}"][:location]=coffee["location"]["display_address"]
    end
  binding.pry
  end
# if location == String || location == ""
# error_message
