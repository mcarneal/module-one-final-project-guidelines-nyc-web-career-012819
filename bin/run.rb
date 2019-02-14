require_relative '../config/environment'
# song = fork{exec "afplay", "../lib/audio/jazz.mp3"}
pid = fork{ exec 'afplay', "lib/audio/jazz.mp3" }




user = get_user
coffee_search = zip_search
coffee_array = coffee_list(coffee_search)
clean_list(coffee_array)



favorite_coffee(coffee_array)



puts "bye bye"
