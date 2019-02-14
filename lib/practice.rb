# Whirly.start spinner: "pong"
# Whirly.status = "LOADING"
# sleep 4
# Whirly.stop
#
#
# Whirly.start spinner: "pong"
# Whirly.status = "GATHERING COFFEE SHOPS"
# sleep 4
# Whirly.stop
#
#

# Whirly.start spinner: "dots"
# Whirly.status = "I am now DEACTIVATED"
# sleep 1
# Whirly.stop

# def scroll_text(text)
#   text.each_char do |c|
#     print c
#     sleep (0.002)
#   end
# end











# #
# # shops = CoffeeShop.all.each do |shop|
# #   puts "name: #{coffeeshop.name}, location: #{coffeeshop.location} "
# def favorite_coffee(coffee_array, user)
#
#   puts "\nWould you like to add a coffee to favorites?\n
#   (YES or NO)"
#   answer = gets.chomp
#   if answer == "yes"
#     puts "\n Please enter your number choice 1 - 5"
#     selection = gets.chomp.to_i
#
#     shop_name = coffee_array[selection -1]["coffee shop #{selection}"][:name]
#
#     shop_location = coffee_array[selection -1]["coffee shop #{selection}"][:location].join(" ")
#
#     find_user_id = User.find_by(name: user).id
#
#       c1 = CoffeeShop.find_by(name: shop_name)
#
#       binding.pry
#       if
#         Favorite.find_by(user_id: User.find_by(name: user).id, coffee_shop_id: c1.id)
#           puts "You have already have this in your favorites"
#           menu
#
#       else
#         # Favorite.find_by(user_id: find_user_id, coffee_shop_id: c1.id)
#
#         CoffeeShop.find_or_create_by(name: shop_name, location: shop_location)
#
#         Favorite.find_or_create_by(name: shop_name, location: shop_location, user_id: find_user_id, coffee_shop_id: CoffeeShop.find_by(name: shop_name).id)
#         menu
#       end
#     elsif answer == "no"
#       menu
#     else
#       error_message
#       favorite_coffee(coffee_array, user)
#       menu
#     end
#   end
