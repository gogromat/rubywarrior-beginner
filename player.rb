class Player

  FULL_HEALTH = 20

  def initialize
    @direction = :right
    @going_right = true
    @walking_away_to_rest = false
    @last_health = FULL_HEALTH
  end
  
  def play_turn(warrior)
    
    @warrior = warrior
    @direction = get_direction
    
    
    if needs_rest?
      if can_rest_here?
        # no enemy, it's chill out here, let me rest
        @warrior.rest!
      else
        # getting damage right now, need to walk away
        walk_away!
      end
    else
      @walking_away_to_rest = false
      # no need to rest, let's see...
      
      if is_wall_there?
        # it's a wall here, let's turn around
        turn_around!
      elsif is_captive_there?
        # rescue captive
        @warrior.rescue!(:backward)
      elsif is_empty_there?
        # nothing here, move on
        @warrior.walk!(@direction)
      elsif is_enemy_there?
        # attack an enemy
        @warrior.attack!(@direction)
      else
        
      end
      
    end
    
    update_health
  end
  
  def get_direction
    return @going_right == true ? :right : :left
  end
  
  def walk_away!
    @warrior.walk!(opposite_direction)
  end
  
  def opposite_direction
    return (@direction == :left ? :right : :left)
  end
  
  def turn_around!
    @going_right = !@going_right
    @warrior.pivot!(opposite_direction)
    @direction = opposite_direction
  end
  
  def is_wall_there?
    @warrior.feel(@direction).wall?
  end
  
  def is_captive_there?
    @warrior.feel(@direction).captive?
  end
  
  def is_enemy_there?
    @warrior.feel(@direction).enemy?
  end
  
  def is_empty_there?
    @warrior.feel(@direction).empty?
  end

  def needs_rest?
    if being_hit?
      if is_enemy_there?
        return !healthy_enough_to_fight_melee_enemy?
      else
        return !healthy_enough_to_fight_ranged_enemy?
      end
    else
      return !full_health?
    end
  end
  
  def can_rest_here?
    (!being_hit? && !full_health?) 
  end

  def being_hit?
    @warrior.health < get_last_health
  end

  def update_health
    @last_health = @warrior.health
  end

  def get_last_health
    @last_health
  end

  def full_health?
    get_warrior_health == FULL_HEALTH
  end

  def healthy_enough_to_fight_melee_enemy?
    get_warrior_health >= FULL_HEALTH/3
  end
  
  def healthy_enough_to_fight_ranged_enemy?
    get_warrior_health >= FULL_HEALTH/1.5
  end
  
  def get_warrior_health
    @warrior.health
  end
  
end