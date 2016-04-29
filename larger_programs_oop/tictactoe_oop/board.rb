# Class that generates the board
class Board
  attr_accessor :position_values

  INITIAL_MARKER = ' '
  PLAYER_MARKER = 'X'
  CPU_MARKER = 'O'
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @position_values = initialize_board
  end

  # Displays the TTT board
  def display_board
    system 'clear'
    puts "You're #{PLAYER_MARKER}. Computer is #{CPU_MARKER}. "
    puts ''
    puts '     |     |'
    puts "  #{position_values[1]}  |  #{position_values[2]}  |  #{position_values[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{position_values[4]}  |  #{position_values[5]}  |  #{position_values[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{position_values[7]}  |  #{position_values[8]}  |  #{position_values[9]}"
    puts '     |     |'
    puts ''
  end

  # Initialize a empty TTT board
  def initialize_board
    new_board = {}
    (1..9).each { |num| new_board[num] = INITIAL_MARKER }
    new_board
  end
end
