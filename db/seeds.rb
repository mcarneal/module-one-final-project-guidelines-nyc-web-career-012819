michael = User.find_or_create_by(name: "Michael", age: 29, location: "Brookyln New York")
robert = User.find_or_create_by(name: "Robert" ,location:"Englewood New York")

cf1 = CoffeeShop.find_or_create_by(name: "My Organic Coffee", location: "Brooklyn")
cf2 = CoffeeShop.find_or_create_by(name: "Java no Batha", location: "Tataoine")
cf3 = CoffeeShop.find_or_create_by(name: "Your way caffee", location: "Brooklyn New York")


r1 = Review.find_or_create_by(rating: 4, message: "Good ol cup of joe", user_id: michael.id, coffee_shop_id:  cf1.id)

r2 = Review.find_or_create_by(rating: 2, message: "they burned my coffee and ruined my morning", user_id: robert.id, coffee_shop_id: cf2.id)

r3 = Review.find_or_create_by(rating: 3, message: "It was ok, nothing special", user_id: michael.id, coffee_shop_id: cf3.id)
