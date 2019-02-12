require_relative '../config/environment'




def find_coffee
  shop_name = {}
  coffee_search = YelpApiAdapter.search("coffee", 11237)
  coffee_search.each do |shops|
  end
end
