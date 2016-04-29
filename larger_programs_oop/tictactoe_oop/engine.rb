require_relative './board'
require_relative './play'

# Main class
class Engine
  # Prompts a default message
  def prompt(message)
    puts "=> #{message}"
  end

  # Checks if someone won the game
  def someone_won?(brd)
    !!detect_winner(brd)
  end

  # Detect who was the winner
  def detect_winner(brd)
    Board::WINNING_LINES.each do |line|
      if brd.position_values[line[0]] == Board::PLAYER_MARKER &&
         brd.position_values[line[1]] == Board::PLAYER_MARKER &&
         brd.position_values[line[2]] == Board::PLAYER_MARKER
        return 'Player'
      elsif brd.position_values[line[0]] == Board::CPU_MARKER &&
            brd.position_values[line[1]] == Board::CPU_MARKER &&
            brd.position_values[line[2]] == Board::CPU_MARKER
        return 'CPU'
      end
    end
    nil
  end

  # Start the app
  def start_game
    current_player = ' '
    option = ' '
    coin = %w(h t)
    loop do
      brd = Board.new
      ply = Play.new(brd)
      loop do
        prompt 'Choose heads or tails!'
        option = gets.chomp.downcase[0, 1]
        system 'clear'
        option == 'h' || option == 't' ? break : prompt('Invalid choice!')
      end

      if coin.sample == option
        current_player = 'PLR'
      else
        current_player = 'CPU'
      end

      loop do
        brd.display_board
        ply.place_piece!(brd, current_player)
        current_player = ply.alternate_player(current_player)
        break if someone_won?(brd) || ply.board_full?(brd)
      end

      brd.display_board

      if someone_won?(brd)
        prompt "#{detect_winner(brd)} won!"
      else
        prompt 'It is a tie!'
      end

      prompt 'Play again? (y or n)'
      answer = gets.chomp
      system 'clear'
      break unless answer.downcase.start_with?('y')
    end
  end
end

engine = Engine.new
engine.start_game
