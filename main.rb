require './game_board'
require './ship'

board = GameBoard.new
board.print_key

def get_coordinates(guess)
  matchdata = /([a-p])(\d{1,2})/.match(guess)
  return false if matchdata.nil?

  horizontal = matchdata[1]
  vertical = matchdata[2].to_i
  return false if vertical > 16 || vertical < 1
  [horizontal, vertical]
end

def get_guesses
  guesses = []
  (1..5).each do |i|
    good_guess = false
    until good_guess
      puts "Guess #{i}"
      guess = gets
      coordinates = get_coordinates(guess.chomp)
      if coordinates
        guesses.push coordinates
        good_guess = true
      else
        puts "bad guess!"
      end
    end
  end
  guesses
end

6.times do
  guesses = get_guesses
  guesses.each do |h,v|
    board.guess(h,v)
  end
  board.print_hits
end
