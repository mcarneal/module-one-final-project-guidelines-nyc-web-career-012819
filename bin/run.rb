require_relative '../config/environment'


welcome
user = get_user
coffee_search = zip_search
coffee_array = coffee_list(coffee_search)
clean_list(coffee_array)
binding.pry

favorite_coffee(coffee_array, user)



puts "bye bye"
