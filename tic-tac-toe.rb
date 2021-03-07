class TicTacToe
  def initialize
    @board = []
  end

  def play
    new_game
    spaces_played = []
    loop do # Game loop
      place_marker(spaces_played, 'X')
      end_text('X') if game_over?
      return if game_over?

      place_marker(spaces_played, 'O')
      end_text('O') if game_over?
      return if game_over?
    end
  end

  protected

  def display_board
    puts "\n<<  TIC TAC TOE  >>\n\n"
    puts '     |     |     '
    puts "  #{@board[0][0]}  |  #{@board[0][1]}  |  #{@board[0][2]}  "
    puts '_____|_____|_____'
    puts '     |     |     '
    puts "  #{@board[1][0]}  |  #{@board[1][1]}  |  #{@board[1][2]}  "
    puts '_____|_____|_____'
    puts '     |     |     '
    puts "  #{@board[2][0]}  |  #{@board[2][1]}  |  #{@board[2][2]}  "
    puts "     |     |     \n\n"
  end

  def new_game
    @board = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    display_board
  end

  def mark(position, marker)
    case position
    when 'top-left'
      @board[0][0] = marker
    when 'top'
      @board[0][1] = marker
    when 'top-right'
      @board[0][2] = marker
    when 'left'
      @board[1][0] = marker
    when 'center'
      @board[1][1] = marker
    when 'right'
      @board[1][2] = marker
    when 'bottom-left'
      @board[2][0] = marker
    when 'bottom'
      @board[2][1] = marker
    when 'bottom-right'
      @board[2][2] = marker
    else
      'Invalid'
    end
  end

  def place_marker(arr, marker)
    puts "Place your marker. (#{marker})"
    puts 'Valid Inputs: top-left, top, top-right, left, center, right, bottom-left, bottom, bottom-right'
    answer = gets.chomp
    marker_placed = false
    until marker_placed
      if arr.include? answer
        puts 'That space is already taken. Try a different one.'
        answer = gets.chomp
      elsif mark(answer, marker) == 'Invalid'
        puts 'Invalid Input. Try again.'
        answer = gets.chomp
      else
        arr.push(answer)
        mark(answer, marker)
        marker_placed = true
        display_board
      end
    end
  end

  def winner(marker)
    [
      (@board[0].all? marker), # Top row
      (@board[1].all? marker), # Middle row
      (@board[2].all? marker), # Bottom row
      ([@board[0][0], @board[1][0], @board[2][0]].all? marker), # Left column
      ([@board[0][1], @board[1][1], @board[2][1]].all? marker), # Middle column
      ([@board[0][2], @board[1][2], @board[2][2]].all? marker), # Right column
      ([@board[0][0], @board[1][1], @board[2][2]].all? marker), # Descending diagonal
      ([@board[2][0], @board[1][1], @board[0][2]].all? marker)  # Ascending diagonal
    ].any? true
  end

  def draw
    @board.flatten.none? ' '
  end

  def game_over?
    (winner('X') || winner('O')) || draw
  end

  def end_text(marker)
    puts winner(marker) ? "#{marker} wins!" : 'Draw!'
  end
end

game = TicTacToe.new
loop do
  puts 'Would you like to play a game of Tic Tac Toe (y/n)?'
  answer = gets.chomp.downcase
  case answer
  when 'y' || 'yes'
    game.play
  when 'n' || 'no'
    return
  else
    puts 'Invalid response. Type "y" or "n".'
  end
end
