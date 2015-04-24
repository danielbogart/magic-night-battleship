require 'ship'

class GameBoard

	attr_accessor :board 
	attr_accessor :ships
	attr_accessor :taken_spaces

	def initialize
		reset_board
		ships = [:aircraft_carrier, :battleship, :submarine, :destroyer, :cruiser, :patrol_boat].map { |name| 
			Ship.new(ships) 
		}
	end
	
	def print_board

	end

	def reset_board
		@board = Array.new(16) { Array.new(16) }
	end

	def letter_to_number(letter)
		letter_values = Hash[("a".."p").to_a.map.with_index.to_a]
		letter_values[letter]
	end

	def guess(position)
		horizontal = letter_to_number(position[0])
		@board[horizontal][position[1].to_i]
	end

	def place_ships(ship)
		horizontal = rand(0..15)
		vertical = rand(0..15)
		direction = Rand(0,3)

		case direction
		when 0
			can_place_up(ship, horizontal, vertical)
			place_this_ship(ship, horizontal, vertical, up)
		when 1
			can_place_right(ship, horizontal, vertical)
			place_this_ship(ship, horizontal, vertical, right)
		when 2
			can_place_down(ship, horizontal, vertical)
			place_this_ship(ship, horizontal, vertical, down)
		when 3
			can_place_left(ship, horizontal, vertical)
			place_this_ship(ship, horizontal, vertical, left)
		else
			place_ships(ship)
		end
	end

	def can_place_up(ship, horizontal, vertical)
		if horizontal - ship.size >= 0
			puts true
		else 
			puts false
		end
	end 

	def can_place_right(ship, horizontal, vertical)
		if vertical + ship.size <= 15
			puts true
		else 
			puts false
		end
	end
	
	def can_place_down(ship, horizontal, vertical)
		if horizontal + ship.size <= 15
			puts true
		else 
			puts false
		end
	end
	
	def can_place_left(ship, horizontal, vertical)
		if vertical - ship.size >= 0
			puts true
		else 
			puts false
		end
	end

	place_this_ship(ship, horizontal, vertical, direction)

	end

	def empty

	end
end
