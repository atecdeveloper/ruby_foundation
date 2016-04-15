INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
CPU_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals

# Prompts a default message
def prompt(message)
  puts "=> #{message}"
end

# Displays the TTT board
def display_board(brd)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{CPU_MARKER}. "
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

# Initialize a empty TTT board
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

# Shows all empty squares
def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

# Decide who going to play in that turn
def place_piece!(brd, crt_player)
  case crt_player
  when 'PLR'
    player_places_piece!(brd)
  when 'CPU'
    computer_places_piece!(brd)
  end
end

# Alternate player between turns
def alternate_player(crt_player)
  if crt_player == 'PLR'
    return 'CPU'
  elsif crt_player == 'CPU'
    return 'PLR'
  end
end

# Chooses where the player wants to mark in the board
def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(brd).join(', ')}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end

  brd[square] = PLAYER_MARKER
end

# CPU search for a immediate threat
def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    mark = board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }
    mark.keys.first
  end
end

# Chooses where the CPU will mark in the board
def computer_places_piece!(brd)
  square = nil

  # offensive move
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, CPU_MARKER)
    break if square
  end

  # defensive move
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  # optimized first move, choose the center
  if empty_squares(brd).include?(5)
    square = 5
  end

  # neutral move
  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = CPU_MARKER
end

# Checks if the board is full
def board_full?(brd)
  empty_squares(brd).empty?
end

# Checks if someone won the game
def someone_won?(brd)
  !!detect_winner(brd)
end

# Detect who was the winner
def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
      return 'Player'
    elsif brd[line[0]] == CPU_MARKER &&
          brd[line[1]] == CPU_MARKER &&
          brd[line[2]] == CPU_MARKER
      return 'CPU'
    end
  end
  nil
end

current_player = ' '
option = ' '
start = %w(h t)
loop do
  board = initialize_board

  loop do
    prompt 'Choose heads or tails!'
    option = gets.chomp.downcase[0, 1]
    system 'clear'
    option == 'h' || option == 't' ? break : prompt('Invalid choice!')
  end

  if start.sample == option
    current_player = 'PLR'
  else
    current_player = 'CPU'
  end

  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt 'It is a tie!'
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  system 'clear'
  break unless answer.downcase.start_with?('y')
end
