require "json"
require "http"
require "pry"
require "paint"

def scroll_text(text)
  text.each_char do |c|
    print c
    sleep (0.003)
  end
end

def static_logo
  "
     ██╗ █████╗ ██╗   ██╗ █████╗     ███████╗███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
     ██║██╔══██╗██║   ██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
     ██║███████║██║   ██║███████║    ███████╗█████╗  ███████║██████╔╝██║     ███████║
██   ██║██╔══██║╚██╗ ██╔╝██╔══██║    ╚════██║██╔══╝  ██╔══██║██╔══██╗██║     ██╔══██║
╚█████╔╝██║  ██║ ╚████╔╝ ██║  ██║    ███████║███████╗██║  ██║██║  ██║╚██████╗██║  ██║
 ╚════╝ ╚═╝  ╚═╝  ╚═══╝  ╚═╝  ╚═╝    ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝

".green

end



def logo
  system"clear"
  scroll_text("
     ██╗ █████╗ ██╗   ██╗ █████╗     ███████╗███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
     ██║██╔══██╗██║   ██║██╔══██╗    ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
     ██║███████║██║   ██║███████║    ███████╗█████╗  ███████║██████╔╝██║     ███████║
██   ██║██╔══██║╚██╗ ██╔╝██╔══██║    ╚════██║██╔══╝  ██╔══██║██╔══██╗██║     ██╔══██║
╚█████╔╝██║  ██║ ╚████╔╝ ██║  ██║    ███████║███████╗██║  ██║██║  ██║╚██████╗██║  ██║
 ╚════╝ ╚═╝  ╚═╝  ╚═══╝  ╚═╝  ╚═╝    ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝

".green)

end





def welcome
  # system "clear"
  logo



#   print "\033c"
# puts Paint["Earth Spinner", :underline]

Whirly.start spinner: "earth"
Whirly.status = "INITIALIZING COFFEE DATABASE"
sleep 2.5
Whirly.stop


# Whirly.start spinner: "pong"
# Whirly.status = "GATHERING COFFEE SHOPS"
# sleep 4
# Whirly.stop

end

def get_user
  static_logo
  puts"\n Please enter your username"
  @user_name = gets.chomp.strip
  if User.find_by(name: @user_name)
    puts "Welcome back #{@user_name}"
    Whirly.start spinner: "pong"
    Whirly.status = "LOADING"
    sleep 2
    Whirly.stop
    sleep 1
  else
    puts "welcome new user, please enter your home location"
    location = gets.chomp
    User.create(name: @user_name, location: location)
  end
@user_name
system "clear"
end



def zip_search
  puts static_logo
  puts "Where would you like to search for coffee? Please enter zip code"
  location = gets.chomp
  if location.length == 5

  coffee_search = YelpApiAdapter.search("coffee", location)
    if coffee_search == nil
      error_message
      zip_search
    end

  else
    error_message
    sleep 1
    system "clear"
    zip_search
  end

  Whirly.start spinner: "pong"
  Whirly.status = "GATHERING COFFEE SHOPS"
  sleep 2
  Whirly.stop
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

def favorite_coffee(coffee_array)

  puts "\nWould you like to add a coffee to favorites?
Type yes or no (y/n)"
  answer = gets.chomp
  if answer == "yes" || answer == "y" || answer == "YES" || answer == "Y"
    puts "\n Please enter your number choice 1 - 5"
    selection = gets.chomp.to_i

    shop_name = coffee_array[selection -1]["coffee shop #{selection}"][:name]

    shop_location = coffee_array[selection -1]["coffee shop #{selection}"][:location].join(" ")

    find_user_id = User.find_by(name: @user_name).id

    # c1 = CoffeeShop.new(name: shop_name, location: shop_location)
# binding.pry
#     f1 = Favorite.find_by(name: shop_name, user_id: find_user_id)

      # if f1 = nil
      #    puts "Adding to your favorites"
         CoffeeShop.find_or_create_by(name: shop_name, location: shop_location)

         Favorite.find_or_create_by(name: shop_name, location: shop_location, user_id: find_user_id, coffee_shop_id: CoffeeShop.find_by(name: shop_name).id)
         menu
    #
    #
    # CoffeeShop.find_or_create_by(name: shop_name, location: shop_location)
    #
    # Favorite.find_or_create_by(name: shop_name, location: shop_location, user_id: find_user_id, coffee_shop_id: CoffeeShop.find_by(name: shop_name).id)



  elsif answer == "no" || answer == "n" || answer == "NO" || answer == "N"
    system "clear"
    menu
  else
    error_message
    favorite_coffee(coffee_array)
    menu
  end
end


  # option_1 = "#{coffee_arr[0]["coffee shop 1"]["name"]}\n #{coffee_arr[0]["coffee shop 1"]["location"]["display_address"]}"
#
# puts "#{coffee_arr[0]["coffee shop 1"][:name]}"
def my_favorite_shops
  User.find_by(name: @user_name).coffee_shops
end

def list_of_favorites
  static_logo
  counter = 1
  my_favorite_shops.each do |shop|
    puts "\n#{counter}   #{shop.name} \n Location: #{shop.location}"
    counter += 1
  end
  puts "\nReturn to menu? \nType yes or no (y/n)"
    answer = gets.chomp
    if answer == "yes" || answer == "y" || answer == "YES" || answer == "Y"
      system"clear"
      menu
    elsif answer == "no" || answer == "n" || answer == "NO" || answer == "N"
      exit_app
    else
      system"clear"
      puts "Incorrect entry"
      list_of_favorites
    end
end

def delete_favorites_list
  counter = 1
  my_favorite_shops.each do |shop|
    puts "\n#{counter}   #{shop.name} \n Location: #{shop.location}"
    counter += 1
  end
end


def menu
  system "clear"
  static_logo
  puts "
  Main MENU
    --1--  Get me more JAVA!
    --2--  View favorites
    --3--  Delete favorites
    --4--  EXIT App
    "
    input = gets.chomp
    if input == "1"
      system "clear"
      user = get_user
      get_me_more_java(user)
    elsif input == "2"
      system "clear"
      list_of_favorites
    elsif input == "3"
      system "clear"
      delete_favorites
    elsif input == "4"
      exit_app
    else
      puts "Please select from the following:"
      menu
    end
  end

def delete_favorites
  static_logo
  puts "
    DELETE MENU
    --1--  Delete a specific favorite
    --2--  Delete all favorites
    --3--  Return to Main MENU
    "
    input = gets.chomp
    if input == "1"
      system "clear"
      static_logo
      delete_favorites_list
      puts "Please type in the **EXACT** name of the coffeeshop you would like to delete"
      delete_shop = gets.chomp

      shop_name_list = delete_favorites_list.map do |shop|
        shop.name
      end

      if shop_name_list.include?(delete_shop)

        shop = Favorite.find_by(name: delete_shop, user_id: User.find_by(name: @user_name))
        shop.destroy
        system "clear"
        puts "Now removing #{delete_shop} from your favorites list"
        delete_favorites

      else
        system "clear"
        static_logo
        puts  "Incorrect entry"
        delete_favorites
      end

    elsif input == "2"
      static_logo
      user_id = User.find_by(name: @user_name).id
      delete_list = Favorite.all
      delete_list.map do |favorite|
        if favorite.user_id == user_id
          favorite.destroy
        end
      end
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
  if input != CoffeeShop.find_by(name: input)
    puts "Sorry, there must be a typo please try again"
    delete_favorites
  else
    shop_to_delete = Coffeeshop.find_by(name: input)
  shop_to_delete.destroy
  puts "#{input} has been successfully deleted "
  delete_favorites
  end
end

def exit_app
  puts "Thank you for using JAVA SEARCH: Where a fresh brew is just around the corner!"
  Whirly.start spinner: "dots"
  Whirly.status = "JAVA SEARCH"
  sleep 2
  Whirly.stop

  puts

  Whirly.start spinner: "dots"
  Whirly.status = "Shutting Down"
  sleep 2
  Whirly.stop

  system"killall afplay"
  system "clear"

  # exit!
end

def get_me_more_java(user)
  coffee_search = zip_search
  coffee_array = coffee_list(coffee_search)
  clean_list(coffee_array)
  favorite_coffee(coffee_array)
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
