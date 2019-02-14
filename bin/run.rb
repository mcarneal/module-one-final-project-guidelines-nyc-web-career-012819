require_relative '../config/environment'
# song = fork{exec "afplay", "../lib/audio/jazz.mp3"}
pid = fork{ exec 'afplay', "lib/audio/jazz.mp3" }

start



puts "bye bye"
