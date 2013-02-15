class Player

  #instance variable to check the health
  def initialize
    @last_health = 20
  end

  def set_new_health
    @last_health = @warrior.health
  end

  def get_last_health
    @last_health
  end

  def get_warrior_health
    @warrior.health
  end

  def full_health?
    get_warrior_health == 20
  end

  def play_turn(warrior)
    @warrior = warrior

    # check space in front
    if warrior.feel.empty?
      walk_or_rest
    # or attack 
    else
    	warrior.attack!
    end

    set_new_health
  end


  def walk_or_rest
      # let warrior rest
      if !full_health? && !being_hit?
        # adds 2 HP 
        @warrior.rest!
      # go forward
      else
        @warrior.walk!
      end
  end

  def being_hit?
    @warrior.health < get_last_health
  end

end
