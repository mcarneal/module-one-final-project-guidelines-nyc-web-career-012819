require_relative '../config/environment'
welcome
user = get_user
coffee_search = zip_search
coffee_array = coffee_list(coffee_search)

def clean_list(coffee_array)
  counter = 0
  coffee_array.each do |shop|
     puts "#{counter + 1}.  #{coffee_array[counter]["coffee shop #{counter +1}"][:name]} \n   Location: #{coffee_array[counter]["coffee shop #{counter +1}"][:location].join(" ")}"
    counter += 1
  end
end

clean_list(coffee_array)


# "1.  #{coffee_array[0]["coffee shop 1"][:name]}   #{coffee_array[0]["coffee shop 1"][:location]}"
#


# def find_coffee
#   shop_name = {}
#   coffee_search = YelpApiAdapter.search("coffee", 11237)
#   coffee_search.each do |shops|
#   end
# end
