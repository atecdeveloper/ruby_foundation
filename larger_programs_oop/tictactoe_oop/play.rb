class Play
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  # Prompts a default message
  def prompt(message)
    puts "=> #{message}"
  end

  # Shows all empty squares
  def empty_squares(brd)
    brd.position_values.keys.select { |num| brd.position_values[num] == Board::INITIAL_MARKER }
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

    brd.position_values[square] = Board::PLAYER_MARKER
  end

  # CPU search for a immediate threat
  def find_at_risk_square(line, board, marker)
    if board.position_values.values_at(*line).count(marker) == 2
      mark = board.position_values.select { |k, v| line.include?(k) && v == Board::INITIAL_MARKER }
      mark.keys.first
    end
  end

  # Chooses where the CPU will mark in the board
  def computer_places_piece!(brd)
    square = nil

    # offensive move
    Board::WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, Board::CPU_MARKER)
      break if square
    end

    # defensive move
    if !square
      Board::WINNING_LINES.each do |line|
        square = find_at_risk_square(line, brd, Board::PLAYER_MARKER)
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

    brd.position_values[square] = Board::CPU_MARKER
  end

  # Checks if the board is full
  def board_full?(brd)
    empty_squares(brd).empty?
  end
end
