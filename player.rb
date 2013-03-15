class Player

  # Thoughts. 
  # Now we walk both backward and forward
  # We need to walk backward at first, and
  # do the same in a loop, and then
  # change directions and do the rest in a loop
  @have_walked_backward_fully = false


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

  def half_health?
    get_warrior_health <= 10
  end

  def deside_on_direction
  
    if !@have_walked_backward_fully

      feel = @warrior.feel(:backward)

      if feel.wall?
        @have_walked_backward_fully = true
        return :forward
      else
        return :backward
      end

    else
      return :forward
    end
  end

  def switch_direction(direction = :forward)
    return (direction == :forward ? :backward : :forward)
  end



  def play_turn(warrior)
    @warrior = warrior

    direction = deside_on_direction

    # check space in front
    if warrior.feel(direction).empty?
      walk_or_rest(direction)
    # or attack 
    elsif warrior.feel(direction).captive?
      # rescue backward by default
      warrior.rescue!(:backward)
    else
    	warrior.attack!(direction)
    end

    set_new_health
  end


  def walk_or_rest(direction = :forward)

      # let warrior rest
      if !full_health? && !being_hit?
        # adds 2 HP 
        @warrior.rest!
      #being hit, need to go different direction
      elsif being_hit? && half_health?
        @warrior.walk!(switch_direction(direction))
      # go forward
      else
        @warrior.walk!(direction)
      end
  end

  def being_hit?
    @warrior.health < get_last_health
  end

end
