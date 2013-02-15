class Player
  def play_turn(warrior)
    
    # check space in front
    if warrior.feel.empty?

	    # let warrior rest
	    if warrior.health < 20
	    	# adds 2 HP 
	    	warrior.rest!
		# go forward
		else
			warrior.walk!
		end

	# or attack 
    else
    	warrior.attack!
    end

  end
end
