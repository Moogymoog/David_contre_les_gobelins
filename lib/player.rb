class Player
    attr_accessor :name, :life_points

    def initialize(name, life_points = 10)
        @name = name
        @life_points = life_points
    end

    def show_state
        puts "#{@name} a #{@life_points} points de vie."
    end

    def gets_damage(damage_received)
        @life_points -= damage_received
        if @life_points <= 0
          puts "le joueur #{@name} a été tué !"
          @life_points = 0
        end
    end

    def attacks(player_attacked)
        puts "le joueur #{self.name} attaque le joueur #{player_attacked.name}"
        damage_done = compute_damage
        puts "il lui inflige #{damage_done} points de dommages"
        player_attacked.gets_damage(damage_done)
    end

    def compute_damage
        return rand(1..6)
    end

end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name, life_points = 100, weapon_level = 1)
      @name = name
      @life_points = life_points
      @weapon_level = weapon_level
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
  end

  def compute_damage
    return rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}."
    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    health_pack = rand(1..6)
    case health_pack
    when 1
      puts "Tu n'as rien trouvé... "
    when 2..5
      if @life_points + 50 < 100
        @life_points += 50
      else @life_points = 100
      end
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
    when 6
      if @life_points + 80 < 100
        @life_points += 80
      else @life_points = 100
      end
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
    end
  end

end