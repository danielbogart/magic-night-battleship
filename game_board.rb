
class GameBoard
  attr_accessor :board
  attr_accessor :ships
  attr_accessor :hits

  DIRECTIONS = [:up, :down, :left, :right]

  def initialize
    reset_board
    self.ships = [:aircraft_carrier, :battleship, :submarine,
                  :destroyer, :cruiser, :patrol_boat].map { |name|
      Ship.new(name)
    }
    @hits = Array.new(16) { Array.new(16) }
    place_ships
  end

  def self.print_board(board_to_print)
    print_row('  ', ('a'..'p').to_a)
    puts '=' * 68
    board_to_print.each_with_index do |row, i|
      print_row(i + 1, row)
      print_spacer_row
    end
  end

  def self.print_row(row_number, row)
    row_number = format('%02d', row_number) if row_number.is_a? Integer
    printable_row = [row_number] + row.map { |c| c ? c : ' ' }
    puts printable_row.join(' | ') + ' |'
  end

  def self.print_spacer_row
    puts '---+' * 17
  end

  def guess(horizontal, vertical)
    horizontal = letter_to_number(horizontal)
    vertical = vertical - 1
    if @board[vertical][horizontal].nil?
      @hits[vertical][horizontal] = 'O'
    else
      @hits[vertical][horizontal] = 'X'
    end
  end

  def print_hits
    GameBoard.print_board(@hits)
  end

  def print_key
    GameBoard.print_board(@board)
  end

  def reset_board
    @board = Array.new(16) { Array.new(16) }
  end

  def letter_to_number(letter)
    letter_values = Hash[('a'..'p').to_a.map.with_index.to_a]
    letter_values[letter]
  end

  def place_ship(ship)
    horizontal = rand(0..15)
    vertical = rand(0..15)
    direction = DIRECTIONS[rand(0..3)]
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
    ships.each do |ship|
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
    true
  end

  def can_place_right(ship, horizontal, vertical)
    return false unless vertical + ship.size <= 15
    (0..ship.size).each do |i|
      return false unless @board[horizontal][vertical + i]
    end
    true
  end

  def can_place_down(ship, horizontal, vertical)
    return false unless horizontal + ship.size <= 15
    (0..ship.size).each do |i|
      return false unless @board[horizontal + i][vertical]
    end
    true
  end

  def can_place_left(ship, horizontal, vertical)
    return false unless vertical - ship.size >= 0
    (0..ship.size).each do |i|
      return false unless @board[horizontal][vertical - i]
    end
    true
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
