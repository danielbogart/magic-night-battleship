require 'ship'

class GameBoard

	attr_accessor :board
	attr_accessor :ships
	attr_accessor :taken_spaces

	DIRECTIONS = [:up, :down, :left, :right]

	def initialize
		reset_board
		ships = [:aircraft_carrier, :battleship, :submarine, :destroyer, :cruiser, :patrol_boat].map { |name|
			Ship.new(ships)
		}
	end

	def print_board
    print_row('  ', ('a'..'p').to_a)
    puts "="*68
    board.each_with_index do |row, i|
      print_row(i+1, row)
      print_spacer_row
    end
	end

  def print_row(row_number, row)
    row_number = format('%02d', row_number) if row_number.is_a? Integer
    puts row.unshift(row_number).join(' | ') + " |"
  end

  def print_spacer_row
    puts "---+" * 17
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

	def place_ship(ship)
		horizontal = rand(0..15)
		vertical = rand(0..15)
		direction = DIRECTIONS[rand(0,3)]
		case direction
		when :up
			if can_place_up(ship, horizontal, vertical)
				place_this_ship(ship, horizontal, vertical, :up)
			else 
				place_ship(ship)
			end
		when :right
			if can_place_right(ship, horizontal, vertical)
				place_this_ship(ship, horizontal, vertical, :right)
			else 
				place_ship(ship)
			end
		when :down
			if can_place_down(ship, horizontal, vertical)
				place_this_ship(ship, horizontal, vertical, :down)
			else 
				place_ship(ship)
			end
		when :left
			if can_place_left(ship, horizontal, vertical)
				place_this_ship(ship, horizontal, vertical, :left)
			else 
				place_ship(ship)
			end
		end
	end


	def place_ships
		self.ships.each do |ship|
			place_ship(ship)
		end


		
	end

	def can_place_direction?(direction)
		case direction
		when 0
			can_place_up(ship, horizontal, vertical)
			place_this_ship(ship, horizontal, vertical, :up)
		when 1
			can_place_right(ship, horizontal, vertical)
			place_this_ship(ship, horizontal, vertical, :right)
		when 2
			can_place_down(ship, horizontal, vertical)
			place_this_ship(ship, horizontal, vertical, :down)
		when 3
			can_place_left(ship, horizontal, vertical)
			place_this_ship(ship, horizontal, vertical, :left)
		end
	end

	def can_place_up(ship, horizontal, vertical)
		return false unless horizontal - ship.size >= 0 
			(0..ship.size).each do |i| 
				return false unless @board[horizontal - i][vertical].nil?
			end
			return true
	end

	def can_place_right(ship, horizontal, vertical)
		return false unless vertical + ship.size <= 15
			(0..ship.size).each do |i| 
				return false unless @board[horizontal][vertical + i]
			end
			return true
	end

	def can_place_down(ship, horizontal, vertical)
		return false unless horizontal + ship.size <= 15
			(0..ship.size).each do |i| 
				return false unless @board[horizontal + i][vertical]
			end
			return true
	end

	def can_place_left(ship, horizontal, vertical)
		return false unless vertical - ship.size >= 0
			(0..ship.size).each do |i| 
				return false unless @board[horizontal][vertical - i]
			end
			return true
	end

	def place_this_ship(ship, horizontal, vertical, direction)

		case direction
		when :up
			(0..ship.size).each do |i| 
				@board[horizontal - i][vertical] = ship
			end
		when :right
			(0..ship.size).each do |i| 
				@board[horizontal][vertical + i] = ship
			end
		when :down
			(0..ship.size).each do |i| 
				@board[horizontal + i][vertical] = ship
			end
		when :left
			(0..ship.size).each do |i| 
				@board[horizontal][vertical - i] = ship
			end
		end
	end

	def empty?(horizontal, vertical)
		@board[horizontal][vertical].nil?

	end
end
