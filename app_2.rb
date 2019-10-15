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
user = HumanPlayer.new(gets.chomp)
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]
while user.life_points > 0 && enemies.inject(0) { |sum, enemy| sum + enemy.life_points } > 0
    
    puts
    puts "Voici l'état de votre joueur :"
    user.show_state
    gets.chomp
    puts "Quelle action veux-tu effectuer ?"
    puts
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts
    puts "attaquer un joueur en vue :"
    puts "0 - "
    print player1.show_state
    puts "1 - "
    print player2.show_state
    puts
    print "> "
    choice = gets.chomp
    case choice
    when "a"
        user.search_weapon
    when "s"
        user.search_health_pack
    when "0"
        user.attacks(player1)
    when "1"
        user.attacks(player2)
    else
        puts "Tu n'as pas fait de choix valable. Dommage, tu perds ton tour !"
    end
    gets.chomp
    puts "Les autres joueurs t'attaquent !" unless enemies.inject(0) { |sum, enemy| sum + enemy.life_points } <= 0
    enemies.each { |enemy| 
        if enemy.life_points > 0 
        enemy.attacks(user)
        gets.chomp
        end
    }

end

puts "La partie est finie" 
gets.chomp
if user.life_points > 0
    puts "BRAVO ! TU AS GAGNE !"
elsif enemies.inject(0) { |sum, enemy| sum + enemy.life_points } > 0
    puts "Loser ! Tu as perdu !"
end
