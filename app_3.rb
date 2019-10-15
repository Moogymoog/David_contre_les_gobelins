require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts <<-'EOF'
__          __  _                              ______       _               _   _                                         
\ \        / / | |                            |  ____|     (_)             | | | |                                        
 \ \  /\  / /__| | ___ ___  _ __ ___   ___    | |__   _ __  _  ___  _   _  | |_| |__   ___    __ _  __ _ _ __ ___   ___   
  \ \/  \/ / _ \ |/ __/ _ \| '_ ` _ \ / _ \   |  __| | '_ \| |/ _ \| | | | | __| '_ \ / _ \  / _` |/ _` | '_ ` _ \ / _ \  
   \  /\  /  __/ | (_| (_) | | | | | |  __/_  | |____| | | | | (_) | |_| | | |_| | | |  __/ | (_| | (_| | | | | | |  __/_ 
    \/  \/ \___|_|\___\___/|_| |_| |_|\___(_) |______|_| |_| |\___/ \__, |  \__|_| |_|\___|  \__, |\__,_|_| |_| |_|\___(_)
                                                          _/ |       __/ |                    __/ |                       
                                                         |__/       |___/                    |___/                        

                                              
EOF

puts "Prénom"
my_game = Game.new(gets.chomp)
puts

while my_game.is_still_ongoing?
    my_game.show_players
    my_game.new_players_in_sight
    gets.chomp
    my_game.menu
    my_game.menu_choice(gets.chomp)
    gets.chomp
    my_game.enemies_in_sight_attack
end

my_game.end
