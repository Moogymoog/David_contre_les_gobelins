class Game
    attr_accessor :human_player, :players_left, :enemies_in_sight

    def initialize(user)
        @human_player = HumanPlayer.new(user)
        @enemies_in_sight = Array.new
        @players_left = 10
    end

    def random_name
        names = ["Akbug", "Argav", "Brigadve", "Corbakl", "Cruncha", "Frum", "Gelmax", "Glibl", "Glogroth Von Bloov", "Glovd", "Gorf", "Grelth", "Grickstah", "Griga", "Groovilla Dar Trog", "Khroongah", "Kosrik", "Makdur", "Porgl", "Throngul", "Thuk", "Tryxtah", "Vorla", "Yorvua"]
        string = names.sample
        names.delete(string)
        return string
    end

    def new_players_in_sight
        new_players_in_sight = rand(1..6)
        if @enemies_in_sight.length == @players_left
            puts "Tous les joueurs sont déjà en vue"
        else
            case new_players_in_sight
            when 1
                puts "Aucun nouveau gobelin ne vous attaque."
            when 2..4
                @enemies_in_sight << Player.new(random_name)
                puts "Un nouveau gobelin vous attaque !"
            when 5..6
                @enemies_in_sight << Player.new(random_name)
                @enemies_in_sight << Player.new(random_name)
                puts "Deux nouveaux gobelins vous attaquent !"
            end
        end
    end

    def kill_player(dead)
        @enemies_in_sight.delete(dead)
        @players_left -= 1
    end

    def is_still_ongoing?
        @human_player.life_points > 0 && @players_left > 0
    end

    def show_players
        @human_player.show_state
        puts "Il reste #{@players_left} adversaires."
        puts
    end

    def menu
        puts "Quelle action veux-tu effectuer ?"
        puts
        puts "a - chercher une meilleure arme"
        puts "s - chercher à se soigner "
        puts
        puts "attaquer un joueur en vue :"
        puts
        @enemies_in_sight.each { |enemy| 
            print "#{@enemies_in_sight.index(enemy)} - " 
            print enemy.show_state 
        }
        puts
        print "> "
    end

    def menu_choice(choice)
        puts
        if choice =~ /[[:alpha:]]/
            case choice
            when "a"
                @human_player.search_weapon
            when "s"
                @human_player.search_health_pack
            else
                puts "Tu n'as pas fait de choix valable. Dommage, tu perds ton tour !"
            end
        elsif choice =~ /[[:digit:]]/
            if (choice.to_i).between?(0, @enemies_in_sight.length)
                @human_player.attacks(@enemies_in_sight[choice.to_i]) 
                if @enemies_in_sight[choice.to_i].life_points <= 0
                    kill_player(@enemies_in_sight[choice.to_i])
                end
            else puts "Tu n'as pas fait de choix valable. Dommage, tu perds ton tour !"
            end
        else 
            puts "Tu n'as pas fait de choix valable. Dommage, tu perds ton tour !"
        end
    end

    def enemies_in_sight_attack
        puts "Les autres joueurs t'attaquent !" unless @players_left <= 0
        @enemies_in_sight.each { |enemy| 
            if enemy.life_points > 0 
            enemy.attacks(@human_player)
            gets.chomp
                if @human_player.life_points <= 0
                    break
                end
            end
        }
    end

    def end
        puts "La partie est finie" 
        gets.chomp
        if @human_player.life_points > 0
            puts "BRAVO ! TU AS GAGNE !"
        elsif @players_left > 0
            puts "Loser ! Tu as perdu !"
        end
    end

end 